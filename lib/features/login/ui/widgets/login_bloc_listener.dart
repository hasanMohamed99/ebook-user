import 'package:ebook_task_user/core/routing/routes.dart';
import 'package:ebook_task_user/core/theming/colors.dart';
import 'package:ebook_task_user/core/theming/styles.dart';
import 'package:ebook_task_user/features/login/logic/login_cubit.dart';
import 'package:ebook_task_user/features/login/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => const SizedBox.shrink(),
              barrierDismissible: false,
            );
          },
          success: (response) async {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.green,
                content: Text('Login Success',
                    style: TextStyles.font16White500Weight),
              ),
            );
            context.go(Routes.homeScreen);
          },
          error: (error) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.red,
                content: Text(
                  error,
                  style: TextStyles.font16White500Weight,
                ),
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
