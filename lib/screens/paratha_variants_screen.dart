import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'paratha_detail_screen.dart';

class ParathaVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const ParathaVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class ParathaVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const ParathaVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<ParathaVariant> parathaVariants = const [
    ParathaVariant(
      name: 'Aloo Paratha',
      image: 'lib/assets/images/aloo_paratha.jpg',
      price: 89,
      rating: 4.3,
      deliveryTime: '20-30 min',
    ),
    ParathaVariant(
      name: 'Paneer Paratha',
      image: 'lib/assets/images/paneer_paratha.jpg',
      price: 109,
      rating: 4.6,
      deliveryTime: '25-35 min',
    ),
    ParathaVariant(
      name: 'Methi Paratha',
      image: 'lib/assets/images/methi_paratha.jpg',
      price: 79,
      rating: 4.2,
      deliveryTime: '20-30 min',
    ),
    ParathaVariant(
      name: 'Mix Veg Paratha',
      image: 'lib/assets/images/mix_veg_paratha.jpg',
      price: 99,
      rating: 4.4,
      deliveryTime: '25-35 min',
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

  void navigateToDetailScreen(BuildContext context, ParathaVariant paratha) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParathaDetailScreen(
          name: paratha.name,
          image: paratha.image,
          price: paratha.price,
          rating: paratha.rating,
          deliveryTime: paratha.deliveryTime,
          description:
          'Enjoy our delicious ${paratha.name} made with fresh ingredients, traditional spices, and love. A perfect delight for any time of the day!',
          onAddToCart: (item) => updateCart(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paratha Variants'),
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
        itemCount: parathaVariants.length,
        itemBuilder: (context, index) {
          final paratha = parathaVariants[index];
          return GestureDetector(
            onTap: () => navigateToDetailScreen(context, paratha),
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
                      paratha.image,
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
                            paratha.name,
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
                              Text('${paratha.rating}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(paratha.deliveryTime, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${paratha.price}',
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
                                  'name': paratha.name,
                                  'image': paratha.image,
                                  'price': paratha.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${paratha.name} added to cart'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
