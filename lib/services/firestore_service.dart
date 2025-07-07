import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Method to save address in Firestore
Future<void> saveAddress(String address) async {
  // Get the current logged-in user
  User? user = FirebaseAuth.instance.currentUser;

  // Check if the user is logged in
  if (user != null) {
    try {
      // Reference to the Firestore collection for addresses
      CollectionReference addresses = FirebaseFirestore.instance.collection('addresses');

      // Save the address using the current user's UID as the document ID
      await addresses.doc(user.uid).set({
        'address': address,  // The user's address
        'createdAt': Timestamp.now(),  // Timestamp to track when the address was added
      });
    } catch (e) {
      print("Error saving address: $e");
    }
  } else {
    print("User not logged in");
  }
}

// Method to retrieve the saved address from Firestore
Future<String?> getSavedAddress() async {
  // Get the current logged-in user
  User? user = FirebaseAuth.instance.currentUser;

  // Check if the user is logged in
  if (user != null) {
    try {
      // Fetch the document from the addresses collection using the user's UID
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('addresses').doc(user.uid).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Return the saved address
        return snapshot['address'];
      }

      // If no address is saved, return null
      return null;
    } catch (e) {
      print("Error retrieving address: $e");
      return null;
    }
  } else {
    print("User not logged in");
    return null;
  }
}
