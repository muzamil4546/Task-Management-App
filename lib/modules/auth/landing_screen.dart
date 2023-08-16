import 'package:flutter/material.dart';
import 'package:task_management_app/modules/auth/login_screen.dart';
import 'package:task_management_app/modules/auth/signup_screen.dart';
import 'package:task_management_app/utils/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorUtils colorUtils = ColorUtils();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            color: colorUtils.darkBlueColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Organize Your Daily Tasks',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: colorUtils.orangeColor),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: screenHeight * .4,
                        child: Image.asset(
                          'assets/Header image1.jpg',
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 360,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorUtils.darkBlueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Login',
                                style: TextStyle(fontSize: 20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 360,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorUtils.orangeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'SignUp',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
