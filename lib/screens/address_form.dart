import 'package:flutter/material.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({Key? key}) : super(key: key);

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _flatNoController = TextEditingController();
  final _houseNoController = TextEditingController();
  final _streetController = TextEditingController();
  final _pinCodeController = TextEditingController();

  // Variable for location type selection
  String _addressType = 'Home';

  // Function to save the address
  void _saveAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle the address saving logic (e.g., Firebase)
      final name = _nameController.text;
      final address = _addressController.text;
      final flatNo = _flatNoController.text;
      final houseNo = _houseNoController.text;
      final street = _streetController.text;
      final pinCode = _pinCodeController.text;

      // Combine the entered details into a single address string
      final newAddress = "$name, $address, Flat No: $flatNo, House No: $houseNo, Street: $street, Pin Code: $pinCode, Address Type: $_addressType";

      // Return the new address to the previous screen
      Navigator.pop(context, newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Address"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Flat No Field
              TextFormField(
                controller: _flatNoController,
                decoration: const InputDecoration(
                  labelText: 'Flat No',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your flat number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // House No Field
              TextFormField(
                controller: _houseNoController,
                decoration: const InputDecoration(
                  labelText: 'House No',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your house number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Street Field
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Pin Code Field
              TextFormField(
                controller: _pinCodeController,
                decoration: const InputDecoration(
                  labelText: 'Pin Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pin code';
                  }
                  if (value.length != 6) {
                    return 'Pin code must be 6 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),

              // Address Type Selection with Icons (Home, Work, Other)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home Address
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.home, color: _addressType == 'Home' ? Colors.deepPurple : Colors.grey),
                        onPressed: () {
                          setState(() {
                            _addressType = 'Home';
                          });
                        },
                      ),
                      const Text('Home'),
                    ],
                  ),
                  // Work Address
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.work, color: _addressType == 'Work' ? Colors.deepPurple : Colors.grey),
                        onPressed: () {
                          setState(() {
                            _addressType = 'Work';
                          });
                        },
                      ),
                      const Text('Work'),
                    ],
                  ),
                  // Other Address
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.location_on, color: _addressType == 'Other' ? Colors.deepPurple : Colors.grey),
                        onPressed: () {
                          setState(() {
                            _addressType = 'Other';
                          });
                        },
                      ),
                      const Text('Other'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Save Button
              ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,  // Button background color
                  foregroundColor: Colors.white,       // Button text color
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
