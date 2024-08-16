import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/features/profile/presentation/screens/update_profile_page.dart';
import 'package:news_connect/src/features/profile/presentation/screens/widgets/update_profile.dart';

import '../../../../common/widgets/divider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final scaffoldMessage = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenWithOpacity40,
        title: Center(
            child: Padding(
          padding: EdgeInsets.only(right: 50.sp),
          child: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.greenWithOpacity40, // Color of the container
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.r),
                    bottomRight: Radius.circular(100.r),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 58.h,
                          width: 58.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/news_image.jpg'),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              const Dividerr(),
              OptionCard(
                  icon: Icons.privacy_tip,
                  text: "Privacy And Policy",
                  subText: "View privacy and policy",
                  onPressed: () {}),
              const Dividerr(),
              OptionCard(
                  icon: Icons.settings,
                  text: "Settings",
                  subText: "View Settings",
                  onPressed: () {}),
              const Dividerr(),
              OptionCard(
                  icon: Icons.history,
                  text: "Transaction History",
                  subText: "View  transaction history",
                  onPressed: () {}),
              const Dividerr(),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.sp),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenWithOpacity40,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateProfilePage()));
                    },
                    child: Text(
                      'Update Profile',
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
