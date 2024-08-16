import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/routes_manager.dart';
import 'package:news_connect/src/common/widgets/email_text_field.dart';
import 'package:news_connect/src/common/widgets/password_text_field.dart';
import 'package:news_connect/src/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:news_connect/src/features/authentication/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:news_connect/src/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:news_connect/src/features/authentication/presentation/screens/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signInRequired = false;
  TextEditingController emaailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKKey = GlobalKey<FormState>();
  String? _errorMsg;
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
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          SnackBar(
            content: const Text('Sign In Successful'),
            backgroundColor: AppColors
                .greenWithOpacity40, // Optional: set a background color
            duration:
                const Duration(seconds: 2), // Optional: control the duration
          );
          Navigator.pushNamed(context, Routes.mainRoute);
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = 'Invalid email or password';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_errorMsg!),
              backgroundColor: Colors.red,
              duration:
                  const Duration(seconds: 2), // Optional: control the duration
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
                  padding: EdgeInsets.only(top: 80.sp),
                  child: Center(
                    child: SizedBox(
                      height: 130.h,
                      width: 160.w,
                      child: Image.asset(
                        'assets/images/news_image.jpg',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Welcome To NEWS APP",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Login to your existing account NEWS APP",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height: 35.h,
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
                  height: 20.h,
                ),
                PasswordTextfield(
                    dataController: passController,
                    hintText: "Password",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                    height: 52.h,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(SignInRequired(
                                emaailController.text, passController.text));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors
                              .greenWithOpacity40, // Set the button's background color to purple
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.sp), // Make the button rectangular
                          ),
                        ),
                        child: !signInRequired
                            ? const Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            : SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2),
                              ))),
                SizedBox(height: 10.h),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 10.sp, right: 20.sp),
                          child: Divider(
                            color: Colors.grey,
                            height: 36.h,
                          )),
                    ),
                    Text("OR",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 20.sp, right: 10.sp),
                          child: Divider(
                            color: Colors.grey,
                            height: 36.h,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 89, 81, 81),
                          fontSize: 18.sp,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<SignUpBloc>(
                              create: (context) => SignUpBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository,
                              ),
                              child:
                                  const RegistrationPage(), // Corrected placement of `child`
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.accentBlue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
