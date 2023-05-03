import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/app/app_assets.dart';
import 'package:graduation_project/app/app_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  late Timer _time;
  start() {
    _time = Timer(const Duration(milliseconds: 6000), call);
  }

  void call() {
    Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  void dispose() {
    _time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset(JsonAssets.ai
              //'https://assets1.lottiefiles.com/packages/lf20_itilDAyVNt.json',
              )),
    );
  }
}
