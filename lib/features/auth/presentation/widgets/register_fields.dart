import 'package:flutter/material.dart';

import 'auth_text_field.dart';


class RegisterFields extends StatelessWidget{


  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController confirm;



  const RegisterFields({

    super.key,

    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirm,

  });



  @override
  Widget build(BuildContext context){

    return Column(

      children:[


        AuthTextField(

          label:'الاسم الكامل',

          hint:'أحمد محمد',

          controller:name,

          prefixIcon:const Icon(Icons.person_outline),

        ),


        const SizedBox(height:16),



        AuthTextField(

          label:'البريد الإلكتروني',

          hint:'example@email.com',

          controller:email,

          prefixIcon:const Icon(Icons.email_outlined),

        ),



        const SizedBox(height:16),



        AuthTextField(

          label:'رقم الهاتف',

          hint:'01012345678',

          controller:phone,

          prefixIcon:const Icon(Icons.phone_outlined),

        ),



        const SizedBox(height:16),



        AuthTextField(

          label:'كلمة المرور',

          controller:password,

          isPassword:true, hint: '',

        ),



        const SizedBox(height:16),



        AuthTextField(

          label:'تأكيد كلمة المرور',

          controller:confirm,

          isPassword:true, hint: '',

        ),



      ],

    );

  }

}