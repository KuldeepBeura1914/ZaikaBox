// // lib/screens/phone_auth_screen.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class PhoneAuthScreen extends StatefulWidget {
//   const PhoneAuthScreen({super.key});
//
//   @override
//   State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
// }
//
// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   final _phoneController = TextEditingController();
//   final _otpController = TextEditingController();
//
//   String? _verificationId;
//   bool otpSent = false;
//   bool isLoading = false;
//
//   void _verifyPhoneNumber() async {
//     setState(() => isLoading = true);
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: "+91${_phoneController.text}",
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         Navigator.pushReplacementNamed(context, '/home');
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         setState(() => isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verification failed: ${e.message}")));
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           _verificationId = verificationId;
//           otpSent = true;
//           isLoading = false;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//       },
//     );
//   }
//
//   void _signInWithOtp() async {
//     setState(() => isLoading = true);
//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId!,
//         smsCode: _otpController.text,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("ZaikaBox", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
//                 const SizedBox(height: 24),
//                 TextField(
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     labelText: "Phone Number",
//                     prefixText: "+91 ",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 if (otpSent)
//                   TextField(
//                     controller: _otpController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: "OTP",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 const SizedBox(height: 24),
//                 isLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                   onPressed: otpSent ? _signInWithOtp : _verifyPhoneNumber,
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
//                   child: Text(otpSent ? "Verify OTP" : "Send OTP"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
