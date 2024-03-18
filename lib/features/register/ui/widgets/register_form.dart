import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_titled_text_field.dart';
import '../../logic/register_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    return Form(
      key: registerCubit.registerFormKey,
      child: Column(
        children: [
          AppTitledTextField(
            controller: registerCubit.registerNameController,
            title: 'Name',
            textFormHintText: 'Enter your Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          const VerticalSpace(20),
          AppTitledTextField(
            controller: registerCubit.registerEmailController,
            title: 'Email',
            textFormHintText: 'Enter your email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          const VerticalSpace(20),
          AppTitledTextField(
            isPassword: true,
            controller: registerCubit.registerPasswordController,
            title: 'Password',
            textFormHintText: 'Enter your password',
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              } else if (value.length < 6) {
                return 'Password should be 6 digits';
              } else if (registerCubit.registerPasswordController.text !=
                  registerCubit.registerConfirmPasswordController.text) {
                return 'Password and Confirm Password not same';
              }
              return null;
            },
          ),
          const VerticalSpace(20),
          AppTitledTextField(
            isPassword: true,
            controller:registerCubit.registerConfirmPasswordController,
            title: 'Confirm Password',
            textFormHintText: 'Confirm password',
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              } else if (value.length < 6) {
                return 'Password should be 6 digits';
              } else if (registerCubit.registerPasswordController.text !=
                  registerCubit.registerConfirmPasswordController.text) {
                return 'Password and Confirm Password not same';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
