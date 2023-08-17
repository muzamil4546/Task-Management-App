import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/global_widgets/custom_form_field.dart';
import 'package:task_management_app/utils/colors.dart';
import 'package:task_management_app/utils/utilities.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  final ColorUtils colorUtils = ColorUtils();
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchUsersData(user!.uid);
  }

  Future<void> _updateUsersData() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });
      Utils().successToast('Profile updated successfully');
    } else {
      print('user not updated');
    }
  }

  fetchUsersData(String uid) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .get();
    if (snapshot != null) {
      setState(() {
        userData = snapshot.data()!;
        _firstNameController.text = userData['firstName'] ?? '';
        _lastNameController.text = userData['lastName'] ?? '';
        _phoneController.text = userData['phone'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _passwordController.text = userData['password'] ?? '';
      });
    } else {
      print('=> not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 25),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Update User Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: colorUtils.darkBlueColor,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                  child: Column(
                children: [
                  CustomFormField(
                    label: const Text('First Name'),
                    suffixIcon: const Icon(Icons.person_2_outlined),
                    textEditingController: _firstNameController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    label: const Text('Last Name'),
                    suffixIcon: const Icon(Icons.person_2_outlined),
                    textEditingController: _lastNameController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    label: const Text('Phone No'),
                    suffixIcon: const Icon(Icons.phone_outlined),
                    textEditingController: _phoneController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    label: const Text('Email'),
                    suffixIcon: const Icon(Icons.email_outlined),
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    label: const Text('Password'),
                    suffixIcon: const Icon(Icons.lock_outline),
                    textEditingController: _passwordController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: colorUtils.buttonBorderColor)),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _updateUsersData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorUtils.lightBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Profile',
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
    );
  }
}
