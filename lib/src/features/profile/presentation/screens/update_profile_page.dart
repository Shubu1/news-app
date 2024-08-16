import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/widgets/email_text_field.dart';
import 'package:news_connect/src/features/authentication/domain/model/models.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final scaffoldMessage = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: const Color(0XFFE8EEFA),
      appBar: AppBar(
        backgroundColor: const Color(0XFFE8EEFA),
        title: Text(
          'Update Profile',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 19.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.sp),
                  child: Stack(
                    children: [
                      Center(
                          child: CircleAvatar(
                              radius: 64.r,
                              backgroundImage: const NetworkImage(
                                  'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'))),
                      Positioned(
                        bottom: -10,
                        left: 190,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                    child: Text('Update your Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp))),
                SizedBox(height: 10.h),
                Center(
                    child: Text(
                        'Please fill up form to update your profile details',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp))),
                SizedBox(height: 30.h),
                TextFormFieldd(
                  dataController: nameController,
                  hintText: "Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormFieldd(
                  dataController: ageController,
                  hintText: 'Age',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormFieldd(
                  dataController: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 46.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKKey.currentState!.validate()) {
                        // Get the current user's UID
                        User? currentUser = FirebaseAuth.instance.currentUser;

                        if (currentUser != null) {
                          String uid = currentUser.uid;

                          // Create a new MyUser object with the UID
                          MyUser updatedUser = MyUser(
                            userId: uid,
                            name: nameController.text,
                            age: ageController.text,
                            email: emailController.text,
                          );

                          try {
                            // Update user data in Firestore
                            await setUserData(updatedUser);
                            scaffoldMessage.showSnackBar(SnackBar(
                              content: Text('Profile updated successfully!'),
                              backgroundColor: AppColors.greenWithOpacity40,
                            ));
                          } catch (e) {
                            scaffoldMessage.showSnackBar(SnackBar(
                              content: Text('Failed to update profile: $e'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else {
                          scaffoldMessage.showSnackBar(SnackBar(
                            content: Text('No user is currently signed in.'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenWithOpacity40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r)),
                    ),
                    child: const Text('Update Profile',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setUserData(MyUser myUser) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    try {
      await userCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
