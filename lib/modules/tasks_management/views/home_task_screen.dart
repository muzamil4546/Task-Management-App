import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/auth/views/landing_screen.dart';
import 'package:task_management_app/modules/profile/user_profile_screen.dart';
import 'package:task_management_app/modules/tasks_management/views/tasks_screen.dart';
import 'package:task_management_app/utils/colors.dart';
import 'package:task_management_app/utils/utilities.dart';
import '../widgets/add_task_alert_dialog.dart';

class HomeTaskScreen extends StatefulWidget {
  const HomeTaskScreen({Key? key}) : super(key: key);

  @override
  State<HomeTaskScreen> createState() => _HomeTaskScreenState();
}

class _HomeTaskScreenState extends State<HomeTaskScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final PageController pageController = PageController(initialPage: 0);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    int selectedIndex = 0;
    final colorUtils = ColorUtils();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: colorUtils.lightBlueColor,
          title: const Text('Task Management List'),
          actions: [
            const Padding(padding: EdgeInsets.only(right: 15)),
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LandingScreen()));
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                icon: const Icon(
                  Icons.login_outlined,
                  size: 27,
                ))
          ],
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: keyboardIsOpened
            ? null
            : FloatingActionButton(
                backgroundColor: colorUtils.lightBlueColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AddTaskAlertDialog(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ));
                },
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              ),
        bottomNavigationBar: BottomAppBar(
          color: colorUtils.lightBlueColor,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          notchMargin: 5.0,
          child: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              backgroundColor: colorUtils.lightBlueColor,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.square_list,
                      color: Colors.white,
                      size: 28,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.tag,
                      color: Colors.white,
                      size: 28,
                    ),
                    label: ''),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: pageController,
          children: const [
            Center(
              child: TaskScreen(),
            ),
            UserProfileScreen()
          ],
        ),
      ),
    );
  }
}
