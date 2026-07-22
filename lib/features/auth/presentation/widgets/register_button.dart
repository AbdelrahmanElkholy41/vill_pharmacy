import 'package:flutter/material.dart';


class RegisterButton extends StatelessWidget{


  final VoidCallback onPressed;


  const RegisterButton({

    super.key,

    required this.onPressed,

  });



  @override
  Widget build(BuildContext context){

    return SizedBox(

      width:double.infinity,

      child: ElevatedButton(

        onPressed:onPressed,

        child:const Text(

          'إنشاء حساب',

          style:TextStyle(

            fontSize:18,

            color:Colors.white,

          ),

        ),

      ),

    );

  }

}