import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/screens/home_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 0),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      },));
    },);
  }

  @override
  Widget build(BuildContext context) {
    final scHeight=MediaQuery.sizeOf(context).height*1;
    final scWidth=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash_pic.jpg',
                fit: BoxFit.cover,

                height: scHeight*.5,
              ),
              SizedBox(
                height: scHeight*0.04,
              ),
              Text("Top Headline", style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700),),
              SizedBox(
                height: scHeight*0.04,
              ),

              SpinKitChasingDots(
                color: Colors.blue,
                size: 40,
              )

            ],
          ),
        ),
      ),
    );
  }
}
