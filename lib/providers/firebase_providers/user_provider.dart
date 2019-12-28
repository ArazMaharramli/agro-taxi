
import 'package:agrotaxi/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  final firebaseInstance = Firestore.instance;

  Future<bool> editUserDetails(UserModel user) async {
    await firebaseInstance
        .collection("Users")
        .document(user.uid)
        .setData(user.toMap());
    return true;
  }

  Future<UserModel> getUserDetails(uid) async {
    var userDetailsJson =
        await firebaseInstance.collection("Users").document(uid).get();
    if (userDetailsJson.exists) {
      UserModel user = UserModel.fromJson(userDetailsJson.data);
      user.uid = uid;
      return user;
    }
    return null;
  }
}
