// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fs_task_assesment/services/auth_service.dart';
import 'package:fs_task_assesment/services/user_service.dart';
import 'package:fs_task_assesment/views/auth/sign_in_view.dart';
import 'package:fs_task_assesment/views/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => checkUserLoggedInStatus());
    super.initState();
  }

  void checkUserLoggedInStatus() async {
    final result = await AuthService().checkLoginStatus(UserService());

    if (result.status != false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset("assets/images/splash.svg")),
    );
  }
}
