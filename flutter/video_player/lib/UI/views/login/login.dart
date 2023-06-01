import 'package:flutter/material.dart';
import 'package:video_player/UI/views/movie_page/movie_list_page.dart';
import 'package:video_player/UI/views/register/register.dart';
import 'package:video_player/UI/widgets/outline_button.dart';
import 'package:video_player/controllers/login/login_controller.dart';
import 'package:video_player/services/API/firebase_api.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController controller = LoginController();
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
          key: controller.formKey,
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "LogIn",
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
                      print(value);
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
                  height: 50,
                ),
                SizedBox(
                  width: 250,
                  child: outlineButton(
                      function: () async {
                        if (controller.isFormValid()) {
                          var data = await login(
                              emailAddress: controller.email,
                              password: controller.password);

                          if (data is SnackBar) {
                            ScaffoldMessenger.of(context).showSnackBar(data);
                          } else if (data == 200) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MoviesListPage(),
                                ));
                          }
                        }
                      },
                      text: "Login"),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    child: const Text("Register"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
