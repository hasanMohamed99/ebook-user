import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../login/logic/login_cubit.dart';
import '../../../login/logic/login_state.dart';

class LogoutBlocListener extends StatelessWidget {
  const LogoutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success<bool> || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              barrierDismissible: false,
            );
          },
          success: (response) async {
            context.pop();
            context.go(Routes.loginScreen);
          },
          error: (error) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.red,
                content: Text(
                  error,
                  style: TextStyles.font14White400Weight,
                ),
              ),
            );
          },
        );
      },
      child: ElevatedButton.icon(
        onPressed: () => context.read<LoginCubit>().logout(),
        icon: const Icon(Icons.logout),
        label: Text(
          'LOGOUT',
          style: TextStyles.font14Black500Weight,
        ),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            iconColor: MaterialStateProperty.all(AppColors.black)),
      ),
    );
  }
}
