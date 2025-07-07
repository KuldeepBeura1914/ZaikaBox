import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/promo_banner.dart';
import '../widgets/food_categories.dart';
import '../widgets/popular_items.dart';
import '../screens/drink_variants_screen.dart';
import '../screens/biryani_variants_screen.dart';
import '../screens/pasta_variants_screen.dart';
import '../screens/salad_variants_screen.dart';
import '../screens/paratha_variants_screen.dart';
import '../screens/fries_variants_screen.dart';
import '../screens/sandwich_variant_screen.dart'; // ✅ NEW IMPORT
import 'item_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const HomeScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";

  final List<Map<String, dynamic>> items = [
    {
      "name": "Pizza",
      "price": 150,
      "image": "lib/assets/images/popular\_item\_pizza.jpg",
      "rating": 4.5,
      "description": "Deliciously cheesy pizza with a crispy crust...",
      "isFavorite": false,
    },
    {
      "name": "Cheese Burger",
      "price": 120,
      "image": "lib/assets/images/popular\_item\_burger.jpg",
      "rating": 4.2,
      "description": "Juicy beef patty with melted cheese...",
      "isFavorite": false,
    },
    {
      "name": "Blue Lagoon Mojito",
      "price": 110,
      "image": "lib/assets/images/blue\_lagoon\_mojito.jpg",
      "rating": 4.5,
      "description": "A refreshing mix of lemon, mint, soda, and blue curacao syrup...",
      "isFavorite": false,
    },
    {
      "name": "Fries",
      "price": 70,
      "image": "lib/assets/images/fries.jpg",
      "rating": 4.3,
      "description": "Crispy golden fries served hot...",
      "isFavorite": false,
    },
    {
      "name": "Momos",
      "price": 90,
      "image": "lib/assets/images/momos.jpg",
      "rating": 4.4,
      "description": "Steamed dumplings with spicy chutney...",
      "isFavorite": false,
    },
    {
      "name": "Chicken Tikka",
      "price": 180,
      "image": "lib/assets/images/chicken\_tika.jpg",
      "rating": 4.6,
      "description": "Grilled chicken chunks marinated in spices...",
      "isFavorite": false,
    },
    {
      "name": "Paneer Roll",
      "price": 100,
      "image": "lib/assets/images/paneer\_roll.jpg",
      "rating": 4.3,
      "description": "Spicy paneer wrapped in a soft paratha...",
      "isFavorite": false,
    },
    {
      "name": "Butter Chicken",
      "price": 200,
      "image": "lib/assets/images/butter\_chicken.jpg",
      "rating": 4.7,
      "description": "Creamy and rich butter chicken with gravy...",
      "isFavorite": false,
    },
    {
      "name": "Chole Bhature",
      "price": 110,
      "image": "lib/assets/images/chole\_bhature.jpg",
      "rating": 4.5,
      "description": "Fluffy bhature with spicy chole curry...",
      "isFavorite": false,
    },
    {
      "name": "Masala Dosa",
      "price": 95,
      "image": "lib/assets/images/masala\_dosa.jpg",
      "rating": 4.6,
      "description": "Crispy dosa filled with spiced potato mash...",
      "isFavorite": false,
    },
    {
      "name": "Hakka Noodles",
      "price": 130,
      "image": "lib/assets/images/hakka\_noodles.jpg",
      "rating": 4.4,
      "description": "Stir-fried noodles with veggies and sauces...",
      "isFavorite": false,
    },
    {
      "name": "Gulab Jamun",
      "price": 60,
      "image": "lib/assets/images/gulab\_jamun.jpg",
      "rating": 4.7,
      "description": "Sweet syrup-soaked fried dough balls...",
      "isFavorite": false,
    },
    {
      "name": "Spring Rolls",
      "price": 85,
      "image": "lib/assets/images/spring\_rolls.jpg",
      "rating": 4.3,
      "description": "Crispy rolls stuffed with veggies and noodles...",
      "isFavorite": false,
    },
    {
      "name": "Fried Rice",
      "price": 140,
      "image": "lib/assets/images/fried\_rice.jpg",
      "rating": 4.2,
      "description": "Spicy aromatic rice with mixed vegetables...",
      "isFavorite": false,
    },
    {
      "name": "Rasmalai",
      "price": 90,
      "image": "lib/assets/images/rasmalai.jpg",
      "rating": 4.8,
      "description": "Soft cheese balls soaked in sweetened milk, garnished with nuts...",
      "isFavorite": false,
    },
    {
      "name": "Garlic Bread",
      "price": 80,
      "image": "lib/assets/images/garlic\_bread.jpg",
      "rating": 4.4,
      "description": "Toasted bread with garlic butter and herbs...",
      "isFavorite": false,
    },
    {
      "name": "Chocolate Brownie",
      "price": 100,
      "image": "lib/assets/images/chocolate\_brownie.jpg",
      "rating": 4.6,
      "description": "Rich, fudgy chocolate brownie with a crisp top...",
      "isFavorite": false,
    },
    {
      "name": "Chilly Chicken",
      "price": 160,
      "image": "lib/assets/images/chilly\_chicken.jpg",
      "rating": 4.5,
      "description": "Spicy Indo-Chinese chicken tossed with capsicum and onions...",
      "isFavorite": false,
    },
    {
      "name": "Chicken Popcorn",
      "price": 120,
      "image": "lib/assets/images/chicken\_popcorn.jpg",
      "rating": 4.3,
      "description": "Crunchy bite-sized chicken seasoned with spices...",
      "isFavorite": false,
    },
    {
      "name": "Chicken Nuggets",
      "price": 110,
      "image": "lib/assets/images/chicken\_nuggets.jpg",
      "rating": 4.4,
      "description": "Golden crispy chicken nuggets served with dip...",
      "isFavorite": false,
    },
    {
      "name": "Tandoori Chicken",
      "price": 180,
      "image": "lib/assets/images/tandoori\_chicken.jpg",
      "rating": 4.6,
      "description": "Chargrilled chicken marinated in traditional Indian spices...",
      "isFavorite": false,
    },
    {
      "name": "Garlic Naan",
      "price": 60,
      "image": "lib/assets/images/garlic_naan.jpg",
      "rating": 4.5,
      "description": "Buttery soft flatbread infused with garlic and herbs...",
      "isFavorite": false,
    },
    {
      "name": "Paneer Butter Masala",
      "price": 170,
      "image": "lib/assets/images/paneer_butter_masala.jpg",
      "rating": 4.7,
      "description": "Cottage cheese cubes in creamy tomato gravy...",
      "isFavorite": false,
    },
    {
      "name": "Chicken Shawarma",
      "price": 130,
      "image": "lib/assets/images/chicken_shawarma.jpg",
      "rating": 4.5,
      "description": "Tender grilled chicken wrapped in pita with sauces...",
      "isFavorite": false,
    },
    {
      "name": "Egg Fried Rice",
      "price": 130,
      "image": "lib/assets/images/egg_fried_rice.jpg",
      "rating": 4.4,
      "description": "Flavorful fried rice with scrambled eggs and veggies...",
      "isFavorite": false,
    },
    {
      "name": "Paneer Tikka",
      "price": 150,
      "image": "lib/assets/images/paneer_tikka.jpg",
      "rating": 4.5,
      "description": "Grilled paneer cubes marinated in spices and yogurt...",
      "isFavorite": false,
    },
    {
      "name": "Herb Roasted Chicken",
      "price": 210,
      "image": "lib/assets/images/herb_roasted_chicken.jpg",
      "rating": 4.6,
      "description": "Juicy chicken roasted with aromatic herbs and spices...",
      "isFavorite": false,
    },
    {
      "name": "Spicy Korean Tteokbokki",
      "price": 150,
      "image": "lib/assets/images/tteokbokki.jpg",
      "rating": 4.4,
      "description": "Chewy rice cakes cooked in a sweet and spicy gochujang sauce.",
      "isFavorite": false,
    },
    {
      "name": "Avocado Toast",
      "price": 120,
      "image": "lib/assets/images/avocado_toast.jpg",
      "rating": 4.3,
      "description": "Creamy smashed avocado on toasted sourdough with chili flakes and lemon.",
      "isFavorite": false,
    },
    {
      "name": "Mango Margarita",
      "price": 150,
      "image": "lib/assets/images/mango_margarita.jpg",
      "rating": 4.6,
      "description": "Refreshing cocktail with mango puree, lime, and tequila.",
      "isFavorite": false,
    },
    {
      "name": "Vegetable Korma",
      "price": 170,
      "image": "lib/assets/images/vegetable_korma.jpg",
      "rating": 4.5,
      "description": "Mixed veggies cooked in rich and creamy korma gravy.",
      "isFavorite": false,
    },
    {
      "name": "Chili Garlic Noodles",
      "price": 120,
      "image": "lib/assets/images/chili_garlic_noodles.jpg",
      "rating": 4.4,
      "description": "Stir-fried noodles tossed with chili, garlic, and veggies.",
      "isFavorite": false,
    },
    {
      "name": "Chocolate Lava Cake",
      "price": 150,
      "image": "lib/assets/images/chocolate_lava_cake.jpg",
      "rating": 4.8,
      "description": "Warm chocolate cake with gooey molten center.",
      "isFavorite": false,
    },
    {
      "name": "Mushroom Masala",
      "price": 160,
      "image": "lib/assets/images/mushroom_masala.jpg",
      "rating": 4.3,
      "description": "Mushrooms cooked in a rich and spicy tomato-based gravy.",
      "isFavorite": false,
    },
    {
      "name": "Dal Makhani",
      "price": 150,
      "image": "lib/assets/images/dal_makhani.jpg",
      "rating": 4.5,
      "description": "Creamy black lentils slow-cooked with butter and spices.",
      "isFavorite": false,
    },
    {
      "name": "Garlic Butter Prawns",
      "price": 280,
      "image": "lib/assets/images/garlic_butter_prawns.jpg",
      "rating": 4.7,
      "description": "Succulent prawns sautéed in garlic butter sauce.",
      "isFavorite": false,
    },

  ];

  List<Map<String, dynamic>> get filteredItems {
    if (searchQuery.isEmpty) return items;
    return items.where((item) {
      return item['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(cartItemCount: widget.cartItemCount),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onSearchChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
            const SizedBox(height: 16),
            PromoBanner(),
            const SizedBox(height: 16),
            FoodCategories(
              onTapPizza: () {
                Navigator.pushNamed(context, '/pizza_variants');
              },
              onTapBurger: () {
                Navigator.pushNamed(context, '/burger_variants');
              },
              onTapDrinks: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrinksVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              onTapDessert: () {
                Navigator.pushNamed(context, '/dessert_variants');
              },
              onTapBiryani: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BiryaniVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              onTapPasta: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PastaVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              onTapSalad: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaladVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              onTapParatha: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParathaVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              onTapFries: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriesVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              onTapSandwich: () { // ✅ NEW
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SandwichVariantsScreen(
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            PopularItems(
              onAddToCart: (item) {
                widget.updateCart(item);
              },
              items: filteredItems,
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailScreen(
                      item: item,
                      updateCart: widget.updateCart,
                      cartItemCount: widget.cartItemCount,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
