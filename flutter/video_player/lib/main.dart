import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:video_player/UI/views/login/login.dart';
import 'package:video_player/UI/views/movie_page/movie_list_page.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (error) {
    print(error.toString());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    if (FirebaseAuth.instance.currentUser != null) {
      // signed in
      home = MoviesListPage();
    } else {
      // signed out
      home = Login();
    }
  }

  late Widget home;
  // userAuth() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(body: home),
    );
  }
}
