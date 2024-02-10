import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../services/firebase_services.dart';

String toSentenceCase(String input) {
  if (input.isEmpty) {
    return input;
  }

  // Split the input into sentences based on periods (.)
  List<String> sentences = input.split('.');

  // Capitalize the first letter of each sentence
  for (int i = 0; i < sentences.length; i++) {
    sentences[i] = sentences[i].trim();
    if (sentences[i].isNotEmpty) {
      sentences[i] = sentences[i][0].toUpperCase() + sentences[i].substring(1).toLowerCase();
    }
  }

  // Join the sentences back into a single string
  return sentences.join('. ');
}

Future<bool> doesEmailExist(String email) async {
  try {
    // Reference to the 'users' collection
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    // Query for the document with the matching email
    QuerySnapshot querySnapshot = await usersCollection.where('email', isEqualTo: email)
        .where('email', isNotEqualTo: email).get();
if(querySnapshot.docs.isNotEmpty){
  return true;
}else{
  return false;
}
    // Check if a document with the email exists
    // return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle any potential errors during the process
    print('Error checking email existence: $e');
    return false;
  }
}


bool? search(
    String searchFor,
    String searchIn,
    ) {
  print('ddddddd');
  //return searchIn.contains(searchFor);

  return searchIn.toLowerCase().contains(searchFor.toLowerCase());
}
