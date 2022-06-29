import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:icha_store/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();


}
class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    Timer(Duration(seconds: 4),(){
      Navigator.push(context, MaterialPageRoute(builder: (builder)=>LoginPage() ));
    } );
    super.initState();
  }
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.green,
    body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: TextLiquidFill(
              loadDuration: const Duration(seconds: 2),
              waveDuration: const Duration(seconds: 2),
              boxBackgroundColor:  Colors.green,
              text: 'Icha Store',
              waveColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 70,

              ),
            ),
          ),
        ),

      ],
    ),
  );
}
}


