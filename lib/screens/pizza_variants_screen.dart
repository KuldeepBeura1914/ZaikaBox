import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'pizza_detail_screen.dart'; // <-- Add this

class PizzaVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const PizzaVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class PizzaVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const PizzaVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<PizzaVariant> pizzaVariants = const [
    PizzaVariant(
      name: 'Cheese Pizza',
      image: 'lib/assets/images/cheese_pizza.jpg',
      price: 299,
      rating: 4.5,
      deliveryTime: '30-40 min',
    ),
    PizzaVariant(
      name: 'Veg Pizza',
      image: 'lib/assets/images/veg_pizza.jpg',
      price: 249,
      rating: 4.0,
      deliveryTime: '25-35 min',
    ),
    PizzaVariant(
      name: 'Margherita Pizza',
      image: 'lib/assets/images/margherita_pizza.jpg',
      price: 199,
      rating: 4.8,
      deliveryTime: '20-30 min',
    ),
    PizzaVariant(
      name: 'Pepperoni Pizza',
      image: 'lib/assets/images/pepperoni_pizza.jpg',
      price: 349,
      rating: 4.3,
      deliveryTime: '35-45 min',
    ),
  ];

  void navigateToCartScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Pizza Variants'),
        backgroundColor: Colors.deepPurple,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => navigateToCartScreen(context),
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pizzaVariants.length,
        itemBuilder: (context, index) {
          final pizza = pizzaVariants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PizzaDetailScreen(
                    name: pizza.name,
                    image: pizza.image,
                    price: pizza.price,
                    rating: pizza.rating,
                    deliveryTime: pizza.deliveryTime,
                    description:
                    'Delicious ${pizza.name} loaded with fresh ingredients and a crispy crust. Perfectly baked for pizza lovers!',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                    child: Image.asset(
                      pizza.image,
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pizza.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text('${pizza.rating}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(pizza.deliveryTime, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${pizza.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                updateCart({
                                  'name': pizza.name,
                                  'image': pizza.image,
                                  'price': pizza.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${pizza.name} added to cart'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
