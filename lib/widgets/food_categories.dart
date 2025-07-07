import 'package:flutter/material.dart';

class FoodCategories extends StatelessWidget {
  final VoidCallback onTapPizza;
  final VoidCallback onTapBurger;
  final VoidCallback onTapDrinks;
  final VoidCallback onTapDessert;
  final VoidCallback onTapBiryani;
  final VoidCallback onTapPasta;
  final VoidCallback onTapSalad;
  final VoidCallback onTapParatha;
  final VoidCallback onTapFries;
  final VoidCallback onTapSandwich; // ✅ Added Sandwich

  FoodCategories({
    super.key,
    required this.onTapPizza,
    required this.onTapBurger,
    required this.onTapDrinks,
    required this.onTapDessert,
    required this.onTapBiryani,
    required this.onTapPasta,
    required this.onTapSalad,
    required this.onTapParatha,
    required this.onTapFries,
    required this.onTapSandwich, // ✅ Added
  });

  final List<Map<String, dynamic>> categories = [
    {"name": "Pizza", "image": "lib/assets/images/pizzaaa.jpg"},
    {"name": "Burger", "image": "lib/assets/images/burger.jpg"},
    {"name": "Drinks", "image": "lib/assets/images/drinks.jpg"},
    {"name": "Dessert", "image": "lib/assets/images/dessert.jpg"},
    {"name": "Fries", "image": "lib/assets/images/fries.jpg"},
    {"name": "Sandwich", "image": "lib/assets/images/sandwich.jpg"}, // ✅ Active now
  ];

  final List<Map<String, dynamic>> secondaryCategories = [
    {"name": "Biryani", "image": "lib/assets/images/biryani.jpg"},
    {"name": "Pasta", "image": "lib/assets/images/italian-mac-and-cheese-pasta.jpg"},
    {"name": "Salad", "image": "lib/assets/images/veg-caesar-salad.jpg"},
    {"name": "Paratha", "image": "lib/assets/images/paratha.jpg"},
    {"name": "Veg Thali", "image": "lib/assets/images/veg_thali.jpg"},
    {"name": "Non Veg Thali", "image": "lib/assets/images/non_veg_thali.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Popular Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildAnimatedList(context, categories, true),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Explore More",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildAnimatedList(context, secondaryCategories, false),
      ],
    );
  }

  Widget _buildAnimatedList(BuildContext context, List<Map<String, dynamic>> items, bool isPrimaryList) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1),
            duration: Duration(milliseconds: 500 + index * 100),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () {
                if (isPrimaryList) {
                  switch (items[index]['name']) {
                    case 'Pizza': onTapPizza(); break;
                    case 'Burger': onTapBurger(); break;
                    case 'Drinks': onTapDrinks(); break;
                    case 'Dessert': onTapDessert(); break;
                    case 'Fries': onTapFries(); break;
                    case 'Sandwich': onTapSandwich(); break; // ✅ Activated
                    default: _showComingSoon(context, items[index]['name']);
                  }
                } else {
                  switch (items[index]['name']) {
                    case 'Biryani': onTapBiryani(); break;
                    case 'Pasta': onTapPasta(); break;
                    case 'Salad': onTapSalad(); break;
                    case 'Paratha': onTapParatha(); break;
                    case 'Veg Thali': _showComingSoon(context, 'Veg Thali'); break;
                    case 'Non Veg Thali': _showComingSoon(context, 'Non Veg Thali'); break;
                    default: _showComingSoon(context, items[index]['name']);
                  }
                }
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.deepPurple.shade50,
                    backgroundImage: AssetImage(items[index]['image']),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    items[index]['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showComingSoon(BuildContext context, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$itemName coming soon!')),
    );
  }
}
