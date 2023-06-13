import 'dart:async';
import 'package:flutter/material.dart';
import 'package:services_app/controllers/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:services_app/modals/connectivity_modal.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("home_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/google_logo.png"),
          ),
        ),
      ),
    );
  }
}