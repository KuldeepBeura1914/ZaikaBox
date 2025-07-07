import 'package:flutter/material.dart';

class DrinkDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String deliveryTime;
  final String description;

  const DrinkDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.deliveryTime,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: 250, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.star, size: 20, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text('$rating'),
                  const SizedBox(width: 10),
                  const Icon(Icons.timer, size: 20, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(deliveryTime),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Price: ₹$price", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart logic can be connected later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart")),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                child: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
