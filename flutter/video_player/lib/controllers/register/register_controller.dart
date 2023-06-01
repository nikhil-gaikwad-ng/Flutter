// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterController {
  String email = "";
  String password = "";
  bool isPassowrdVisible = false;
  bool isConfirmPassowrdVisible = false;
  Function state = () {};

  passwordViewToggle() {
    isPassowrdVisible = !isPassowrdVisible;
    state.call();
  }

  confirmPasswordViewToggle() {
    isConfirmPassowrdVisible = !isConfirmPassowrdVisible;
    state.call();
  }

  @override
  String toString() =>
      'RegisterController(email: $email, password: $password, isPassowrdVisible: $isPassowrdVisible)';
}
