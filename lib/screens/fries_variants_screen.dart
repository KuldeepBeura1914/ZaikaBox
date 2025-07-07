import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'fries_details_screen.dart';// <-- New

class FriesVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const FriesVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class FriesVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const FriesVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<FriesVariant> friesVariants = const [
    FriesVariant(
      name: 'Classic Fries',
      image: 'lib/assets/images/classic_fries.jpg',
      price: 99,
      rating: 4.2,
      deliveryTime: '15-20 min',
    ),
    FriesVariant(
      name: 'Peri Peri Fries',
      image: 'lib/assets/images/peri_peri_fries.jpg',
      price: 129,
      rating: 4.5,
      deliveryTime: '20-25 min',
    ),
    FriesVariant(
      name: 'Cheesy Fries',
      image: 'lib/assets/images/cheesy_fries.jpg',
      price: 149,
      rating: 4.6,
      deliveryTime: '20-30 min',
    ),
    FriesVariant(
      name: 'Loaded Fries',
      image: 'lib/assets/images/loaded_fries.jpg',
      price: 169,
      rating: 4.3,
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
        title: const Text('Fries Variants'),
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
        itemCount: friesVariants.length,
        itemBuilder: (context, index) {
          final fries = friesVariants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FriesDetailScreen(
                    name: fries.name,
                    image: fries.image,
                    price: fries.price,
                    rating: fries.rating,
                    deliveryTime: fries.deliveryTime,
                    description:
                    'Crispy ${fries.name} with amazing flavors and seasonings. Perfect snack for every mood!',
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
                    borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)),
                    child: Image.asset(
                      fries.image,
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
                            fries.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text('${fries.rating}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Icon(Icons.timer,
                                  size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(fries.deliveryTime,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${fries.price}',
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
                                  'name': fries.name,
                                  'image': fries.image,
                                  'price': fries.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${fries.name} added to cart'),
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
                              child: const Text('Add to Cart',
                                  style: TextStyle(color: Colors.white)),
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
