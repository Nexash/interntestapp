import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  late String name;
  late String address;
  late int age;
  late int? phoneNo;

  void updateProfile(String name, String address, int age, int? phoneNo) {
    this.name = name;
    this.address = address;
    this.age = age;
    this.phoneNo = phoneNo;
    notifyListeners();
  }
}
