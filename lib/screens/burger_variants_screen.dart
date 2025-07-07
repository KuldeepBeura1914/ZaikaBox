import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'burger_detail_screen.dart';  // Import the BurgerDetailScreen

class BurgerVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const BurgerVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class BurgerVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const BurgerVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<BurgerVariant> burgerVariants = const [
    BurgerVariant(
      name: 'Classic Burger',
      image: 'lib/assets/images/classic_burger.jpg',
      price: 199,
      rating: 4.6,
      deliveryTime: '20-30 min',
    ),
    BurgerVariant(
      name: 'Veggie Burger',
      image: 'lib/assets/images/veggie_burger.jpg',
      price: 179,
      rating: 4.3,
      deliveryTime: '25-35 min',
    ),
    BurgerVariant(
      name: 'Cheese Burger',
      image: 'lib/assets/images/cheese_burger.jpg',
      price: 229,
      rating: 4.7,
      deliveryTime: '15-25 min',
    ),
    BurgerVariant(
      name: 'Chicken Burger',
      image: 'lib/assets/images/chicken_burger.jpg',
      price: 249,
      rating: 4.5,
      deliveryTime: '20-30 min',
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
      appBar: AppBar(
        title: const Text('Burger Variants'),
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
        itemCount: burgerVariants.length,
        itemBuilder: (context, index) {
          final burger = burgerVariants[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: InkWell( // Wrap in InkWell for tap effect
              onTap: () {
                // Navigate to BurgerDetailScreen on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BurgerDetailScreen(
                      name: burger.name,
                      image: burger.image,
                      price: burger.price,
                      rating: burger.rating,
                      deliveryTime: burger.deliveryTime,
                      description:
                      'A tasty ${burger.name} made with fresh ingredients and served with love. Enjoy your bite!',
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.asset(
                      burger.image,
                      height: 120,
                      width: 120,
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
                            burger.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text(
                                '${burger.rating}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${burger.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Delivery: ${burger.deliveryTime}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                updateCart({
                                  'name': burger.name,
                                  'image': burger.image,
                                  'price': burger.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${burger.name} added to cart'),
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
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
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
