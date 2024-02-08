// services/firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToFirestore({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String gender,
  }) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'gender': gender,
      });
    } catch (e) {
      print('Error adding user to Firestore: $e');
      // Handle the error as needed
    }
  }

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('pppppppppp');
        print(querySnapshot.docs.first.data() as Map<String, dynamic>);
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null; // User not found
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

}
