import 'dart:convert';

import 'package:agrotaxi/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInit {
  Future<String> isRegistered() async {
    try {
      var user = await FirebaseAuth.instance.currentUser();
      if (user != null) {
        return user.phoneNumber;
      }
      return null;
    } on PlatformException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserModel> getUserDetails() async {
    var storage = new FlutterSecureStorage();
    String userDetails = await storage.read(key: "userDetails");
    return UserModel.fromJson(json.decode(userDetails));
  }
}
