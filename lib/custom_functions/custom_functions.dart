import 'package:cloud_firestore/cloud_firestore.dart';

class CustomFunctions {
  static String toSentenceCase(String input) {
    if (input.isEmpty) {
      return input;
    }

    List<String> sentences = input.split('.');

    for (int i = 0; i < sentences.length; i++) {
      sentences[i] = sentences[i].trim();
      if (sentences[i].isNotEmpty) {
        sentences[i] =
            sentences[i][0].toUpperCase() + sentences[i].substring(1).toLowerCase();
      }
    }

    return sentences.join('. ');
  }

  static Future<bool> doesEmailExist(String email) async {
    try {
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await usersCollection
          .where('email', isNotEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }

  static Future<bool> emailExist(String email) async {
    try {
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await usersCollection
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }

  static bool? search(String searchFor, String searchIn) {
    return searchIn.toLowerCase().contains(searchFor.toLowerCase());
  }
}
