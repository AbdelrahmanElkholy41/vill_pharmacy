import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../Cubit/register_cubit.dart';

import 'register_fields.dart';
import 'register_button.dart';
import 'register_footer.dart';
import 'role_selector.dart';
import 'auth_header.dart';


class RegisterForm extends StatefulWidget {

  const RegisterForm({super.key});


  @override
  State<RegisterForm> createState()=>_RegisterFormState();

}



class _RegisterFormState extends State<RegisterForm>{


  final formKey = GlobalKey<FormState>();


  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();


  UserRole role = UserRole.customer;



  @override
  void dispose(){

    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirm.dispose();

    super.dispose();

  }



  void submit(){

    if(!formKey.currentState!.validate()) return;


    context.read<RegisterCubit>().register(

      fullName: name.text.trim(),

      email: email.text.trim(),

      phone: phone.text.trim(),

      password: password.text,

      role: role,



    );

  }



  @override
  Widget build(BuildContext context){

    return SingleChildScrollView(

      padding: const EdgeInsets.symmetric(horizontal:24),

      child: Form(

        key: formKey,

        child: Column(

          children:[


            const SizedBox(height:32),


            const AuthHeader(

              title:'إنشاء حساب جديد',

              subtitle:'انضم إلى صيدلية القرية',

            ),



            const SizedBox(height:20),



            RoleSelector(

              selectedRole: role,

              onChanged:(value){

                setState((){

                  role=value;

                });

              },

            ),



            const SizedBox(height:20),



            RegisterFields(

              name:name,

              email:email,

              phone:phone,

              password:password,

              confirm:confirm,

            ),



            const SizedBox(height:25),



            RegisterButton(

              onPressed:submit,

            ),



            const SizedBox(height:15),



            const RegisterFooter(),



          ],

        ),

      ),

    );

  }

}