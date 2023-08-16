import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/auth/landing_screen.dart';
import 'package:task_management_app/utils/colors.dart';
import '../../utils/utilities.dart';

class SignUpScreen extends StatefulWidget {
  final bool loading;
  const SignUpScreen({super.key, this.loading = false});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final colorUtils = ColorUtils();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isValidEmail(String email) {
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegExp.hasMatch(email);
    }

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
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
                      Column(
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: colorUtils.darkBlueColor,
                            ),
                          ),
                          SizedBox(height: screenHeight * .023),
                          Text(
                            'Create your new account',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: colorUtils.subTitleColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .04),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person_2_outlined,
                                  color: colorUtils.lightBlueColor,
                                ),
                                label: const Text(
                                  'First Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                            controller: _firstNameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name is required';
                              } else if (value.length < 5) {
                                return 'Name should not be less than 5 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * .02),
                          TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person_2_outlined,
                                  color: colorUtils.lightBlueColor,
                                ),
                                label: const Text(
                                  'Last Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                            controller: _lastNameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last name is required';
                              } else if (value.length < 5) {
                                return 'Name should not be less than 5 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * .02),
                          TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.phone_outlined,
                                  color: colorUtils.lightBlueColor,
                                ),
                                label: const Text(
                                  'Phone No',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                            keyboardType: TextInputType.number,
                            controller: _phoneController,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone is required';
                              } else if (value.length < 11) {
                                return 'Phone number should not be less than 11 letters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * .02),
                          TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: colorUtils.lightBlueColor,
                                ),
                                label: const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'Email is required';
                              } else if (!_isValidEmail(email)) {
                                return 'Invalid email format';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * .02),
                          TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.lock_outline,
                                  color: colorUtils.lightBlueColor,
                                ),
                                label: const Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                            obscureText: true,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return 'Password should not be less than 8 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * .06),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signUp();
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
                                        strokeWidth: 3,
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Sign up',
                                        style: TextStyle(fontSize: 18),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    setState(() {
      loading = true;
    });
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString())
        .then((value) async {
          await FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'phone': _phoneController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          });
      resetFields();
      Utils().successToast('User Registered Successfully');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LandingScreen()));
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
    setState(() {
      loading = false;
    });
  }

  void resetFields() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
  }
}
