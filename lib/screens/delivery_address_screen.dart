import 'package:flutter/material.dart';
import 'address_form.dart'; // Import your address form screen file
import 'payment_screen.dart'; // Import the PaymentScreen

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  // List to store addresses
  List<String> addresses = [
    "123 Street, City, State - 123456",
    "456 Avenue, City, State - 654321",
  ];

  // Function to update the list of addresses
  void _addNewAddress(String newAddress) {
    setState(() {
      addresses.add(newAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Delivery Address"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: addresses.length + 1,
        itemBuilder: (context, index) {
          if (index == addresses.length) {
            return ListTile(
              title: const Text("Add New Address"),
              leading: const Icon(Icons.add),
              onTap: () {
                // Navigate to the AddressFormScreen and wait for the new address
                _navigateToAddressForm();
              },
            );
          } else {
            return ListTile(
              title: Text(addresses[index]),
              leading: const Icon(Icons.location_on),
              onTap: () {
                // Confirm and move to PaymentScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentScreen()),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Function to navigate to the AddressFormScreen
  void _navigateToAddressForm() async {
    // Wait for the result from the AddressFormScreen
    final newAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddressFormScreen()),
    );

    // If a new address is returned, update the list
    if (newAddress != null && newAddress.isNotEmpty) {
      _addNewAddress(newAddress);
    }
  }
}
