import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'pasta_detail_screen.dart'; // <-- Add this

class PastaVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const PastaVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class PastaVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const PastaVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<PastaVariant> pastaVariants = const [
    PastaVariant(
      name: 'Creamy Alfredo Pasta',
      image: 'lib/assets/images/alfredo_pasta.jpg',
      price: 259,
      rating: 4.6,
      deliveryTime: '25-35 min',
    ),
    PastaVariant(
      name: 'Spaghetti Bolognese',
      image: 'lib/assets/images/spaghetti_bolognese.jpg',
      price: 279,
      rating: 4.4,
      deliveryTime: '30-40 min',
    ),
    PastaVariant(
      name: 'Penne Arrabbiata',
      image: 'lib/assets/images/penne_arrabbiata.jpg',
      price: 239,
      rating: 4.2,
      deliveryTime: '20-30 min',
    ),
    PastaVariant(
      name: 'White Sauce Pasta',
      image: 'lib/assets/images/mac_and_cheese.jpg',
      price: 199,
      rating: 4.7,
      deliveryTime: '20-25 min',
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
        title: const Text('Pasta Variants'),
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
        itemCount: pastaVariants.length,
        itemBuilder: (context, index) {
          final pasta = pastaVariants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PastaDetailScreen(
                    name: pasta.name,
                    image: pasta.image,
                    price: pasta.price,
                    rating: pasta.rating,
                    deliveryTime: pasta.deliveryTime,
                    description: 'Delicious ${pasta.name} made with fresh ingredients!',
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
                      pasta.image,
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
                            pasta.name,
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
                              Text(
                                '${pasta.rating}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                pasta.deliveryTime,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${pasta.price}',
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
                                  'name': pasta.name,
                                  'image': pasta.image,
                                  'price': pasta.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${pasta.name} added to cart'),
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
