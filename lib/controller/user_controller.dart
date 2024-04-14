import 'dart:math';

import 'package:flutter/material.dart';
import 'package:secureprofile/model/user_model.dart';
import 'package:secureprofile/repo/user_repo.dart';
import 'package:secureprofile/screens/user_information.dart';

class UserController {
  Future<void> addUser({
    required String name,
    required String phone,
    required String email,
    required String address,
    required BuildContext context,
  }) async {
    UserRepo userRepo = UserRepo();
    String generateRandomId() =>
        DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(9999).toString().padLeft(4, '0');
    var uid = await userRepo.addUser(UserModel(
        uid: generateRandomId(),
        name: name,
        email: email,
        phone: phone,
        address: address));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserInformation(uid: uid, phone: phone)),
      );
    }
  }

  Future<UserModel?> getUser(String uid) async {
    UserRepo userRepo = UserRepo();
    return await userRepo.getUser(uid);
  }

  void checkUser(String phoneNumber, BuildContext context) async {
    UserRepo userRepo = UserRepo();

    var uid = await userRepo.checkUser(phoneNumber);

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInformation(uid: uid, phone: phoneNumber),
        ),
      );
    }
  }
}
