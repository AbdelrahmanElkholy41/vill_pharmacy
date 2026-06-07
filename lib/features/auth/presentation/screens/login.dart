import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/core/helpers/spacing.dart';

import '../../../../core/theme/app_theme.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/logo1.png"),
          Card(
            color: Colors.white,
            child: Column(
              children: [
                verticalSpace(20.h),
                Text('تسجيل الدخول',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold)),
                verticalSpace(20.h),
               Align(
                 alignment: Alignment.centerRight,
                   child: Text('رقم الهاتف ',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),)

               ),
                verticalSpace(10.h),

              ],
            ),
          )

        ],
      ),
    );
  }
}

