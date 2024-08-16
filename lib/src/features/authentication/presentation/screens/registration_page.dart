import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/routes_manager.dart';
import 'package:news_connect/src/common/widgets/email_text_field.dart';
import 'package:news_connect/src/features/authentication/domain/model/models.dart';
import 'package:news_connect/src/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';

import '../../../../common/widgets/password_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    super.key,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool signUpRequired = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emaailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  // TextEditingController otpController = TextEditingController();
  final formKKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
          Navigator.pushNamed(context, Routes.mainRoute);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Sign up Successful'),
              backgroundColor: AppColors.greenWithOpacity40,
              duration: const Duration(seconds: 2),
            ),
          );

          // Navigator.pop(context);
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            signUpRequired = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: const Text('Sign up failed maybe email already in use'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0XFFE8EEFA),
        body: SingleChildScrollView(
            child: Form(
          key: formKKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.sp),
                  child: Center(
                    child: SizedBox(
                      height: 150.h,
                      width: 150.w,
                      child: Image.asset(
                        'assets/images/news_image.jpg',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormFieldd(
                    dataController: nameController,
                    hintText: " Name ",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Name is required';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 15.h,
                ),
                TextFormFieldd(
                    dataController: ageController,
                    hintText: " Age ",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Age is required';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 15.h,
                ),
                TextFormFieldd(
                    dataController: emaailController,
                    hintText: "Email Address",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 15.h,
                ),
                PasswordTextfield(
                  dataController: passController,
                  hintText: "Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Enter minimum 6 characters';
                    }
                    if (value.contains(' ')) {
                      return 'Do not enter spaces';
                    }
                    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
                      return 'Enter at least one uppercase letter';
                    }
                    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
                      return 'Enter at least one lowercase letter';
                    }
                    if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                      return 'Enter at least one Digit';
                    }
                    if (!RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                      return 'Enter at least one special character';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                PasswordTextfield(
                  dataController: newPassController,
                  hintText: "Confirm Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Enter minimum 6 characters';
                    }
                    if (value.contains(' ')) {
                      return 'Do not enter spaces';
                    }
                    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
                      return 'Enter at least one uppercase letter';
                    }
                    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
                      return 'Enter at least one lowercase letter';
                    }
                    if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                      return 'Enter at least one Digit';
                    }
                    if (!RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                      return 'Enter at least one special character';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed:
                          /* isLoad
                        ? null
                        : */
                          () async {
                        if (formKKey.currentState!.validate()) {
                          MyUser myUser = MyUser.empty;
                          myUser = myUser.copyWith(
                              email: emaailController.text,
                              name: nameController.text,
                              age: ageController.text);
                          setState(() {
                            context.read<SignUpBloc>().add(
                                SignUpRequired(myUser, passController.text));
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenWithOpacity40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: !signUpRequired
                          ? const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            )
                          : SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: const CircularProgressIndicator(
                                  strokeWidth: 2),
                            )),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
