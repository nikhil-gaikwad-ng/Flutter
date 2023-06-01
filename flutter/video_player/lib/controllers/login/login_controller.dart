// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool isPassowrdVisible = false;
  Function state = () {};

  passwordViewToggle() {
    isPassowrdVisible = !isPassowrdVisible;
    state.call();
  }

  bool isFormValid() {
    return formKey.currentState!.validate();
  }

  @override
  String toString() =>
      'LoginController(email: $email, password: $password, isPassowrdVisible: $isPassowrdVisible)';
}
