import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';


class RegisterFooter extends StatelessWidget{


  const RegisterFooter({super.key});



  @override
  Widget build(BuildContext context){

    return Row(

      mainAxisAlignment:MainAxisAlignment.center,

      children:[


        TextButton(

          onPressed:(){

            context.pushReplacementNamed(
                Routes.login
            );

          },


          child:const Text(

            'تسجيل الدخول',

          ),

        ),



        const Text(

          'لديك حساب بالفعل؟',

        ),


      ],

    );

  }

}