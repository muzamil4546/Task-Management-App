import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/tasks_management/views/home_task_screen.dart';
import 'package:task_management_app/utils/colors.dart';

import '../../../utils/utilities.dart';
import '../../global_widgets/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  final bool loading;
  const LoginScreen({super.key, this.loading = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  ColorUtils colorUtils = ColorUtils();

  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/location.webp',
                      height: screenHeight * .23,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Lets sign you in.',
                          style: TextStyle(
                            fontSize: 25,
                            color: colorUtils.darkBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * .03,
                        ),
                        SizedBox(
                          width: 180,
                          child: Text(
                            'Sign-in with your data that you have'
                            'entered during your registration',
                            style: TextStyle(
                                fontSize: 15,
                                color: colorUtils.subTitleColor,
                                height: 1.3),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: screenHeight * .048),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          label: const Text('Email'),
                          suffixIcon: const Icon(Icons.email_outlined),
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Email is required';
                            } else if (!isValidEmail(email)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * .03),
                        CustomFormField(
                          label: const Text('Password'),
                          suffixIcon: const Icon(Icons.lock_outline),
                          textEditingController: _passwordController,
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8) {
                              return 'Password should not be less than 8 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text('Forget Password ?',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: colorUtils.darkBlueColor,
                                        fontWeight: FontWeight.w500)
                                )
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                                FocusScope.of(context).unfocus();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorUtils.darkBlueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: loading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Sign in',
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomeTaskScreen()));
      setState(() {
        loading = false;
      });
      fieldsReset();
      Utils().successToast('Logged In Successfully');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  void fieldsReset() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _passwordController.clear();
  }
}
