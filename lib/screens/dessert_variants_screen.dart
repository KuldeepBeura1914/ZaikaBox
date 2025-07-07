import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'dessert_detail_screen.dart';  // Import DessertDetailScreen

class DessertVariant {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;

  const DessertVariant({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
  });
}

class DessertVariantsScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) updateCart;
  final int cartItemCount;
  final List<Map<String, dynamic>> cartItems;

  const DessertVariantsScreen({
    super.key,
    required this.updateCart,
    required this.cartItemCount,
    required this.cartItems,
  });

  final List<DessertVariant> dessertVariants = const [
    DessertVariant(
      name: 'Chocolate Cake',
      image: 'lib/assets/images/chocolate_cake.jpg',
      price: 299,
      rating: 4.8,
      deliveryTime: '15-25 min',
    ),
    DessertVariant(
      name: 'Ice Cream Sundae',
      image: 'lib/assets/images/ice_cream_sundae.jpg',
      price: 179,
      rating: 4.6,
      deliveryTime: '20-30 min',
    ),
    DessertVariant(
      name: 'Fruit Tart',
      image: 'lib/assets/images/fruit_tart.jpg',
      price: 249,
      rating: 4.7,
      deliveryTime: '25-35 min',
    ),
    DessertVariant(
      name: 'Cheesecake',
      image: 'lib/assets/images/cheesecake.jpg',
      price: 229,
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

  // Function to navigate to DessertDetailScreen
  void navigateToDessertDetailScreen(BuildContext context, DessertVariant dessert) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DessertDetailScreen(
          name: dessert.name,
          image: dessert.image,
          price: dessert.price,
          rating: dessert.rating,
          deliveryTime: dessert.deliveryTime,
          description: 'A delicious dessert made with premium ingredients.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Dessert Variants'),
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
        itemCount: dessertVariants.length,
        itemBuilder: (context, index) {
          final dessert = dessertVariants[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            child: InkWell(
              onTap: () => navigateToDessertDetailScreen(context, dessert),  // Navigate on tap
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                    child: Image.asset(
                      dessert.image,
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
                            dessert.name,
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
                                '${dessert.rating}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                dessert.deliveryTime,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹${dessert.price}',
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
                                  'name': dessert.name,
                                  'image': dessert.image,
                                  'price': dessert.price,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${dessert.name} added to cart'),
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
