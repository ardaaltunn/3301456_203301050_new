import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icha_store/home.dart';
import 'package:icha_store/splashScreen.dart';
import 'package:icha_store/user.dart';
import 'package:icha_store/userProfile.dart';
import 'package:icha_store/userUpdate.dart';
import 'login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        routes: {
          "/":(context)=>SplashScreen (),
          "homepage":(context)=>HomePage(),
        },
    );
  }
}


