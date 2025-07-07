import 'package:flutter/material.dart';
import 'sandwich_detail_screen.dart';
import 'cart_screen.dart'; // Ensure this path is correct

class SandwichVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const SandwichVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class SandwichVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const SandwichVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<SandwichVariant> sandwichVariants = const [
    SandwichVariant(
      name: 'Grilled Chicken Sandwich',
      image: 'lib/assets/images/grilled_chicken_sandwich.jpg',
      price: 139,
      rating: 4.5,
      deliveryTime: '15-20 min',
    ),
    SandwichVariant(
      name: 'Veg Club Sandwich',
      image: 'lib/assets/images/veg_club_sandwich.jpg',
      price: 119,
      rating: 4.3,
      deliveryTime: '20-25 min',
    ),
    SandwichVariant(
      name: 'Paneer Tikka Sandwich',
      image: 'lib/assets/images/paneer_tikka_sandwich.jpg',
      price: 149,
      rating: 4.6,
      deliveryTime: '20-30 min',
    ),
    SandwichVariant(
      name: 'Cheese Corn Sandwich',
      image: 'lib/assets/images/cheese_corn_sandwich.jpg',
      price: 129,
      rating: 4.4,
      deliveryTime: '25-30 min',
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
        title: const Text('Sandwich Variants'),
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
        itemCount: sandwichVariants.length,
        itemBuilder: (context, index) {
          final sandwich = sandwichVariants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SandwichDetailScreen(
                    name: sandwich.name,
                    image: sandwich.image,
                    price: sandwich.price,
                    rating: sandwich.rating,
                    deliveryTime: sandwich.deliveryTime,
                    description:
                    'Delicious ${sandwich.name} with rich ingredients and amazing taste.',
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
                      sandwich.image,
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
                            sandwich.name,
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
                              Text('${sandwich.rating}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(sandwich.deliveryTime,
                                  style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${sandwich.price}',
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
                                  'name': sandwich.name,
                                  'image': sandwich.image,
                                  'price': sandwich.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${sandwich.name} added to cart'),
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
