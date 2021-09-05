import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/models/country_model.dart';
import 'package:chat_app/models/register_request.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FirebaseHelpers {
  FirebaseHelpers._();

  static FirebaseHelpers firebaseHelpers = FirebaseHelpers._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirestoreStrem() {
    return firebaseFirestore
        .collection('Chats')
        .orderBy('dateTime', descending: false)
        .snapshots();
  }

  addMessageToFirbaseFirestore(Map map) async {
    firebaseFirestore.collection('Chats').add({
      ...map,
      'userId': AuthHelper.authHelper.getUserId(),
    });
  }
  // distributionUrl=https\://services.gradle.org/distributions/gradle-7.1.1-bin.zip

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

  Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
    await firebaseFirestore.collection('User').doc(userId).get();
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('User').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
    docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }

  Future<List<CountryModel>> getAllCountry() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('countries').get();
    List<CountryModel> countries = querySnapshot.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      return CountryModel.fromJson(map);
    }).toList();

    return countries;
  }

  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection('User')
        .doc(userModel.id)
        .update(userModel.toMap());
  }

  deleteAllChat() async {
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore
        .instance.collection('Chats');
    QuerySnapshot<Map<String, dynamic>> snapshots = await collection.get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}