import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zaika_box/screens/admin_dashboard_screen.dart';
import 'package:zaika_box/screens/admin_login_screen.dart';


import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/pizza_variants_screen.dart';
import 'screens/burger_variants_screen.dart';
import 'screens/drink_variants_screen.dart';
import 'screens/dessert_variants_screen.dart';
import 'screens/biryani_variants_screen.dart';
import 'screens/pasta_variants_screen.dart';
import 'screens/salad_variants_screen.dart';
import 'screens/paratha_variants_screen.dart'; // ✅ Import Paratha screen

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/view_orders_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/delivery_address_screen.dart';
import 'screens/payment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ZaikaBoxApp());
}

class ZaikaBoxApp extends StatefulWidget {
  const ZaikaBoxApp({super.key});

  @override
  State<ZaikaBoxApp> createState() => _ZaikaBoxAppState();
}

class _ZaikaBoxAppState extends State<ZaikaBoxApp> {
  final List<Map<String, dynamic>> _cartItems = [];

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      _cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZaikaBox',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(
          updateCart: _addToCart,
          cartItemCount: _cartItems.length,
          cartItems: _cartItems,
        ),
        '/cart': (context) => CartScreen(cartItems: _cartItems),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/view_orders': (context) => ViewOrdersScreen(),
        '/edit_profile': (context) => EditProfileScreen(),
        '/delivery_address': (context) => DeliveryAddressScreen(),
        '/payment': (context) => PaymentScreen(),
        '/admin_login': (context) => AdminLoginScreen(),

         '/admin_dashboard': (context) => const AdminDashboardScreen(),
        // '/admin_orders': (context) => AdminOrdersScreen(), // you can build this
        // '/manage_dishes': (context) => ManageDishesScreen(), // build this to add/edit dishes
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/pizza_variants') {
          return MaterialPageRoute(
            builder: (context) => PizzaVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/burger_variants') {
          return MaterialPageRoute(
            builder: (context) => BurgerVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/drinks_variants') {
          return MaterialPageRoute(
            builder: (context) => DrinksVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/dessert_variants') {
          return MaterialPageRoute(
            builder: (context) => DessertVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/biryani_variants') {
          return MaterialPageRoute(
            builder: (context) => BiryaniVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/pasta_variants') {
          return MaterialPageRoute(
            builder: (context) => PastaVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/salad_variants') {
          return MaterialPageRoute(
            builder: (context) => SaladVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        } else if (settings.name == '/paratha_variants') {
          return MaterialPageRoute(
            builder: (context) => ParathaVariantsScreen(
              updateCart: _addToCart,
              cartItemCount: _cartItems.length,
              cartItems: _cartItems,
            ),
          );
        }
        return null;
      },
    );
  }
}
