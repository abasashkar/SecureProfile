import 'package:secureprofile/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String?> addUser(UserModel user) async {
    try {
      await usersCollection.doc(user.uid).set(user.toMap());
      return user.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await usersCollection.doc(userId).get();
      if (documentSnapshot.exists) {
        return UserModel.fromMap(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> checkUser(String phone) async {
    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('phone', isEqualTo: phone).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['uid'];
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
