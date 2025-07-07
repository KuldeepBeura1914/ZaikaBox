import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartItemCount;

  const TopBar({super.key, required this.cartItemCount});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'ZaikaBox',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart),
              if (cartItemCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // User is logged in, go to dashboard
              Navigator.pushNamed(context, '/dashboard');
            } else {
              // Not logged in, go to login
              Navigator.pushNamed(context, '/login');
            }
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
