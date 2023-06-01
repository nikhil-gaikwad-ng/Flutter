import 'package:flutter/material.dart';
import 'package:video_player/UI/widgets/outline_button.dart';
import 'package:video_player/controllers/register/register_controller.dart';
import 'package:video_player/services/API/firebase_api.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterController controller = RegisterController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller.state = () {
      setState(
        () {},
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text("Email")),
                    validator: (value) {
                      if (value == "" || value == null) return "required";
                      controller.email = value;
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextFormField(
                    obscureText: !controller.isPassowrdVisible,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      suffixIcon: GestureDetector(
                          onTap: () => controller.passwordViewToggle(),
                          child: Icon(
                            controller.isPassowrdVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          )),
                    ),
                    validator: (value) {
                      if (value == "" || value == null) return "required";
                      controller.password = value;
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextFormField(
                    obscureText: !controller.isConfirmPassowrdVisible,
                    decoration: InputDecoration(
                      label: const Text("Confirm Password"),
                      suffixIcon: GestureDetector(
                          onTap: () => controller.confirmPasswordViewToggle(),
                          child: Icon(
                            controller.isConfirmPassowrdVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          )),
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "required";
                      } else if (value != controller.password) {
                        return "Password Should be same";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 250,
                  child: outlineButton(
                      function: () async {
                        if (_formKey.currentState!.validate()) {
                          const SnackBar(
                              content: Text(
                                  "Wrong password provided for that user."));

                          print(controller.toString());
                          var data = await registratrion(
                              emailAddress: controller.email,
                              password: controller.password);

                          if (data is SnackBar) {
                            ScaffoldMessenger.of(context).showSnackBar(data);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Accoutn created")));
                            Navigator.pop(context);
                          }
                        }
                      },
                      text: "Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
