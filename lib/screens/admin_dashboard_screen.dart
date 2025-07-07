import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZaikaBox Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading orders"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders available currently"));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final data = orders[index].data() as Map<String, dynamic>;
              final orderId = orders[index].id;

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: $orderId",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 5),
                      Text("Customer: ${data['customerName'] ?? 'N/A'}"),
                      Text("Total Price: ₹${data['totalPrice'] ?? 0}"),
                      Text("Status: ${data['status'] ?? 'Pending'}",
                          style: TextStyle(
                            color: _statusColor(data['status']),
                            fontWeight: FontWeight.w500,
                          )),
                      const Divider(),
                      Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
                      ...((data['items'] ?? []) as List).map((item) {
                        return Text("- ${item['name']} x${item['quantity']}");
                      }),
                      const SizedBox(height: 10),
                      if ((data['status'] ?? 'Pending') == 'Pending')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _updateOrderStatus(orderId, 'Accepted'),
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text('Accept'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                            ),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _updateOrderStatus(orderId, 'Rejected'),
                              icon: const Icon(Icons.cancel_outlined),
                              label: const Text('Reject'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                            ),
                          ],
                        )
                      else
                        Text("Action Taken: ${data['status']}",
                            style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _updateOrderStatus(String orderId, String newStatus) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': newStatus});
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
