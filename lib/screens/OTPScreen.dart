// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../services/auth_service.dart';
//
// class OTPScreen extends StatefulWidget {
//   final String verificationId;
//   const OTPScreen({required this.verificationId});
//
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   final AuthService _authService = AuthService();
//   bool isLoading = false;
//
//   void _verifyCode() async {
//     setState(() => isLoading = true);
//
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: _otpController.text.trim(),
//       );
//       await _authService.signInWithCredential(credential);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Logged in successfully")),
//       );
//       // Navigate to home screen or dashboard
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Invalid OTP")),
//       );
//     }
//
//     setState(() => isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Verify OTP")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _otpController,
//               decoration: InputDecoration(labelText: 'Enter OTP'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: _verifyCode,
//               child: Text("Verify"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
