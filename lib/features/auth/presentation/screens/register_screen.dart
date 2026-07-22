import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';

import '../Cubit/register_cubit.dart';
import '../Cubit/register_state.dart';
import '../widgets/register_form.dart';


class RegisterScreen extends StatelessWidget {

  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<RegisterCubit, RegisterState>(

      listener: (context, state) {

        if(state is RegisterSuccess){

          context.pushNamed(
            Routes.homeScreen,
          );

        }


        if(state is RegisterError){

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.primaryDark,
            ),

          );

        }

      },


      builder: (context,state){

        return const Directionality(

          textDirection: TextDirection.rtl,

          child: Scaffold(

            backgroundColor: AppColors.background,

            body: SafeArea(

              child: RegisterForm(),

            ),

          ),

        );

      },

    );
  }
}