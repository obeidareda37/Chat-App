import 'package:chat_app/models/register_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelpers {
  FirebaseHelpers._();

  static FirebaseHelpers firebaseHelpers = FirebaseHelpers._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      await firebaseFirestore
          .collection('User')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } catch (e) {
      print(e);
    }
  }

  getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('User').doc(userId).get();
    print(documentSnapshot);
  }
}
