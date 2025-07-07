import 'package:flutter/material.dart';
import 'delivery_address_screen.dart'; // Import the DeliveryAddressScreen

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> cartItems;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _couponController = TextEditingController();
  double discount = 0.0;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);

    for (var item in cartItems) {
      item['quantity'] ??= 1;
      item['variant'] ??= 'Classic Biryani'; // Default variant
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0.0,
          (sum, item) => sum + (item['price'] * item['quantity']),
    );

    double finalPrice = totalPrice - discount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F0FF),
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty!",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: cartItems.length,
              itemBuilder: (context, index, animation) {
                final item = cartItems[index];
                return _buildItem(item, animation, index);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                    Text(
                      '₹${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Coupon code field
                TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    labelText: 'Enter Coupon Code',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: _applyCoupon,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount:',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                    Text(
                      '₹${discount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Final Total:',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                    Text(
                      '₹${finalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the DeliveryAddressScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DeliveryAddressScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      "Proceed to Checkout",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _applyCoupon() {
    setState(() {
      String couponCode = _couponController.text.trim();
      if (couponCode == 'DISCOUNT10') {
        discount = 0.1 * cartItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
      } else {
        discount = 0.0;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid coupon code!")),
        );
      }
    });
  }

  Widget _buildItem(Map<String, dynamic> item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              item['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            item['name'],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '₹${item['price']} x ${item['quantity']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _quantityButton(Icons.remove, () {
                    if (item['quantity'] > 1) {
                      setState(() {
                        item['quantity']--;
                      });
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      '${item['quantity']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _quantityButton(Icons.add, () {
                    setState(() {
                      item['quantity']++;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 8),
              // Biriyani Variant
              DropdownButton<String>(
                value: item['variant'],
                onChanged: (String? newValue) {
                  setState(() {
                    item['variant'] = newValue!;
                  });
                },
                items: ['Classic Biryani', 'Chicken Biryani', 'Mutton Biryani', 'Veg Biryani']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 30),
            onPressed: () {
              final removedItem = cartItems[index];

              _listKey.currentState?.removeItem(
                index,
                    (context, animation) => _buildItem(removedItem, animation, index),
                duration: const Duration(milliseconds: 300),
              );

              setState(() {
                widget.cartItems.removeAt(index);
                cartItems.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${removedItem['name']} removed from cart'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: 20,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
