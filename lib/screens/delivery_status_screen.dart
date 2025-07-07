import 'package:flutter/material.dart';

class DeliveryStatusScreen extends StatefulWidget {
  const DeliveryStatusScreen({super.key});

  @override
  State<DeliveryStatusScreen> createState() => _DeliveryStatusScreenState();
}

class _DeliveryStatusScreenState extends State<DeliveryStatusScreen>
    with SingleTickerProviderStateMixin {
  final String orderId = "ZBX123456";
  final List<String> statusSteps = ["Order Placed", "Packed", "Out for Delivery", "Delivered"];
  int currentStep = 2; // Example: Out for Delivery
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStatusStep(int index, String label, IconData icon) {
    bool isActive = index <= currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: isActive ? Colors.deepPurple : Colors.grey[300],
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Status"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Order ID: $orderId", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: Text(
                "Status: ${statusSteps[currentStep]}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 30),

            // Animated Timeline
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatusStep(0, "Placed", Icons.store),
                    _buildStatusStep(1, "Packed", Icons.inventory),
                    _buildStatusStep(2, "Delivery", Icons.delivery_dining),
                    _buildStatusStep(3, "Done", Icons.home),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            // ETA Countdown (you can adjust to live ETA as needed)
            const Text("Estimated Arrival: 20-30 min", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 40),

            // Optional: Map View Icon (Coming Soon)
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text("Map View Coming Soon", style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
