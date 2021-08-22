import 'package:chat_app/models/register_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelpers {
  FirebaseHelpers._();

  static FirebaseHelpers firebaseHelpers = FirebaseHelpers._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      DocumentReference documentReference = await firebaseFirestore
          .collection('User')
          .add(registerRequest.toMap());
    } catch (e) {
      print(e);
    }
  }
}
