import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/auth/landing_screen.dart';
import 'package:task_management_app/modules/tasks_management/home_task_screen.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      Timer(const Duration(seconds: 3), () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
          const HomeTaskScreen())));
    } else {
      Timer(const Duration(seconds: 3), () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
      const LandingScreen())));
    }
  }
}
