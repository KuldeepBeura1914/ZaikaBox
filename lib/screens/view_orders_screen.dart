import 'package:flutter/material.dart';

class ViewOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: Center(
        child: Text(
          'List of your past orders will be displayed here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
