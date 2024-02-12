import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicesWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUserToFirestore({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String gender,
    required String dob,
    required String age,
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
    required DateTime createdTime,
    required String fathername,
    required String mothername,
    required String siblings,
    required String description,
    required String job,
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
        'age': age,
        'height':hgt,
        'weight': wgt,
        'father_name': fathername,
        'mother_name': mothername,
        'siblings': siblings,
        'create_time': createdTime,
        'job': job,
        'description': description
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
        print(querySnapshot.docs.first.id);
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        userData['id'] = querySnapshot.docs.first.id; // fetch doc id
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




