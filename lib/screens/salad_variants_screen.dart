import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'salad_detail_screen.dart';

class SaladVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const SaladVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class SaladVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const SaladVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<SaladVariant> saladVariants = const [
    SaladVariant(
      name: 'Chicken Caesar Salad',
      image: 'lib/assets/images/caesar_salad.jpg',
      price: 199,
      rating: 4.5,
      deliveryTime: '20-30 min',
    ),
    SaladVariant(
      name: 'Greek Salad',
      image: 'lib/assets/images/greek_salad.jpg',
      price: 249,
      rating: 4.2,
      deliveryTime: '25-35 min',
    ),
    SaladVariant(
      name: 'Garden Salad',
      image: 'lib/assets/images/garden_salad.jpg',
      price: 179,
      rating: 4.0,
      deliveryTime: '15-25 min',
    ),
    SaladVariant(
      name: 'Fruit Salad',
      image: 'lib/assets/images/fruit_salad.jpg',
      price: 159,
      rating: 4.7,
      deliveryTime: '10-20 min',
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
        title: const Text('Salad Variants'),
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
        itemCount: saladVariants.length,
        itemBuilder: (context, index) {
          final salad = saladVariants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SaladDetailScreen(
                    name: salad.name,
                    image: salad.image,
                    price: salad.price,
                    rating: salad.rating,
                    deliveryTime: salad.deliveryTime,
                    description:
                    'Freshly made ${salad.name} with seasonal ingredients and dressings.',
                    onAddToCart: (item) {
                      updateCart(item);
                    },
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
                      salad.image,
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
                            salad.name,
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
                              Text('${salad.rating}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(salad.deliveryTime, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${salad.price}',
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
                                  'name': salad.name,
                                  'image': salad.image,
                                  'price': salad.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${salad.name} added to cart'),
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
