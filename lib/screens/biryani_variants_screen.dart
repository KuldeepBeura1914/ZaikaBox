import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'biryani_detail_screen.dart';

class BiryaniVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const BiryaniVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class BiryaniVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const BiryaniVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<BiryaniVariant> biryaniVariants = const [
    BiryaniVariant(
      name: 'Hyderabadi Chicken Biryani',
      image: 'lib/assets/images/hyderabadibiryani.jpg',
      price: 199,
      rating: 4.6,
      deliveryTime: '30-40 min',
    ),
    BiryaniVariant(
      name: 'Veg Biryani',
      image: 'lib/assets/images/veg_biryani.jpg',
      price: 169,
      rating: 4.2,
      deliveryTime: '25-35 min',
    ),
    BiryaniVariant(
      name: 'Chicken Dum Biryani',
      image: 'lib/assets/images/chicken_biryani.jpg',
      price: 229,
      rating: 4.7,
      deliveryTime: '35-45 min',
    ),
    BiryaniVariant(
      name: 'Mutton Biryani',
      image: 'lib/assets/images/mutton_biryani.jpg',
      price: 279,
      rating: 4.8,
      deliveryTime: '40-50 min',
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

  void navigateToDetailScreen(BuildContext context, BiryaniVariant biryani) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BiryaniDetailScreen(
          name: biryani.name,
          image: biryani.image,
          price: biryani.price,
          rating: biryani.rating,
          deliveryTime: biryani.deliveryTime,
          description:
          'A delicious and aromatic ${biryani.name} made with premium spices, long-grain basmati rice, and your favorite ingredients. Served hot and fresh!',
          onAddToCart: (item) => updateCart(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biryani Variants'),
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
        itemCount: biryaniVariants.length,
        itemBuilder: (context, index) {
          final biryani = biryaniVariants[index];
          return GestureDetector(
            onTap: () => navigateToDetailScreen(context, biryani),
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
                      biryani.image,
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
                            biryani.name,
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
                              Text('${biryani.rating}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(biryani.deliveryTime, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${biryani.price}',
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
                                  'name': biryani.name,
                                  'image': biryani.image,
                                  'price': biryani.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${biryani.name} added to cart'),
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
