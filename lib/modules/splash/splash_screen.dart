import 'package:flutter/material.dart';
import 'package:task_management_app/modules/splash/splash_services.dart';
import 'package:task_management_app/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  ColorUtils colorUtils = ColorUtils();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey,
              child: Image.asset('assets/splash logo1.png'),
            ),
            const SizedBox(height: 60),
            Text(
              'Streamline Your Day, Seamlessly',
              style: TextStyle(
                  fontSize: 25,
                  color: colorUtils.darkBlueColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
