// import 'package:flutter/material.dart';
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   void initState(){
//     super.initState();
//     Future.delayed(Duration(seconds: 3),(){
//       Navigator.pushReplacementNamed(context, '/home');
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF9822FF),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.android, size: 100, color: Colors.deepPurple,),
//             Text('ZaikaBox', style: TextStyle(fontSize: 24, color: Colors.white),)
//
//           ],
//         ),
//       ),
//     );
//
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'home_screen.dart'; // Import your HomeScreen
// //
// //
// //
// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});
// //
// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }
// //
// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _navigateToHome();
// //   }
// //
// //   void _navigateToHome() async {
// //     await Future.delayed(const Duration(seconds: 2)); // 2-second wait
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => HomeScreen(
// //           updateCart: (item) {}, // Temporary empty function
// //           cartItemCount: 0,
// //           cartItems: const [], // <-- ADDED this missing argument
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.deepPurple, // Dark Purple background
// //       body: const Center(
// //         child: Text(
// //           'ZaikaBox',
// //           style: TextStyle(
// //             fontSize: 48,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white, // White text for better contrast
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
