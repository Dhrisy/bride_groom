// services/firebase_service.dart

import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToFirestore({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String gender,
    required String dob,

    required String education,
    required String image,
    required String hgt,
    required String wgt,
    required String location,
    required String state,
    required String country,
    required String pincode,
    required String caste,

    required String religion,







    // required String time,
  }) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'gender': gender,
        'image': '',
        'religion': religion,
        'caste': caste,
        'education': education,
        'date_of_birth': dob,
        'location': location,
        'state': state,
        'country': country,
        'pincode': pincode,









        // 'created_time': time
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
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('pppppppppp');
        print(querySnapshot.docs.first.id);
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        userData['id'] = querySnapshot.docs.first.id; // Add document ID to the map
       

        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null; // User not found
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }



  Future<void> updateImage(String user_id) async {
    try {
      await _firestore.collection('users').doc(user_id).update({

      });
    } catch (e) {
      print('Error updating user image: $e');
      // Handle the error as needed
    }
  }

}

class UpdateImageParams {
  final String userId;
  final String name;
  final Map<String, dynamic> additionalData;

  UpdateImageParams({
    required this.userId,
    required this.name,
    required this.additionalData,
  });
}

