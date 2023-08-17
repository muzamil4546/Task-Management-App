import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/auth/views/landing_screen.dart';
import 'package:task_management_app/modules/global_widgets/custom_form_field.dart';
import 'package:task_management_app/utils/colors.dart';
import '../../../utils/utilities.dart';

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
                          CustomFormField(
                            label: const Text('First Name'),
                            suffixIcon: const Icon(Icons.person_2_outlined),
                            textEditingController: _firstNameController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
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
                          CustomFormField(
                            label: const Text('Last Name'),
                            suffixIcon: const Icon(Icons.person_2_outlined),
                            textEditingController: _lastNameController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
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
                          CustomFormField(
                            label: const Text('Phone No'),
                            suffixIcon: const Icon(Icons.phone_outlined),
                            textEditingController: _phoneController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
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
                          CustomFormField(
                            label: const Text('Email'),
                            suffixIcon: const Icon(Icons.email_outlined),
                            textEditingController: _emailController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
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
                          CustomFormField(
                            label: const Text('Password'),
                            suffixIcon: const Icon(Icons.lock_outline),
                            textEditingController: _passwordController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
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
                          SizedBox(height: screenHeight * .06),
                          SizedBox(
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

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
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
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(value.user!.uid)
          .set({
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
