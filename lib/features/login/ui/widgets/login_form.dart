import 'package:ebook_task_user/features/login/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_titled_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTitledTextField(
            controller: context.read<LoginCubit>().emailController,
            title: 'Email',
            textFormHintText: 'Enter your email',
          ),
          const VerticalSpace(20),
          AppTitledTextField(
            isPassword: true,
            controller: context.read<LoginCubit>().passwordController,
            title: 'Password',
            textFormHintText: 'Enter your password',
          ),
        ],
      ),
    );
  }
}
