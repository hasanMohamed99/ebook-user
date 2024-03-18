import 'package:ebook_task_user/core/helpers/spacing.dart';
import 'package:ebook_task_user/core/theming/colors.dart';
import 'package:ebook_task_user/core/theming/styles.dart';
import 'package:ebook_task_user/core/widgets/app_text_button.dart';
import 'package:ebook_task_user/features/login/logic/login_cubit.dart';
import 'package:ebook_task_user/features/login/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/login_bloc_listener.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: AppColors.gray,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 20),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const LoadingWidget(),
              success: (data) => const SizedBox.shrink(),
              error: (message) => const SizedBox.shrink(),
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login to your Account',
                  style: TextStyles.font22Black700Weight,
                ),
                const VerticalSpace(40),
                const LoginForm(),
                const VerticalSpace(40),
                AppTextButton(
                  buttonText: 'Sign In',
                  onPressed: () => context
                      .read<LoginCubit>()
                      .validateLoginControllersThenSend(),
                ),
                const VerticalSpace(20),
                const DividerWidget(title: 'Don\'t have account?'),
                const VerticalSpace(20),
                AppElevatedTextedButton(
                  buttonText: 'Sign Up',
                  onPressed: () => context.go(Routes.registerScreen),
                ),
                const LoginBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
