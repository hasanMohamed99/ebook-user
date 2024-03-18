import 'package:ebook_task_user/core/helpers/extensions.dart';
import 'package:ebook_task_user/core/widgets/loading_widget.dart';
import 'package:ebook_task_user/features/register/data/models/register_request_body.dart';
import 'package:ebook_task_user/features/register/logic/register_cubit.dart';
import 'package:ebook_task_user/features/register/ui/widgets/register_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../logic/register_state.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: AppColors.gray,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 20),
          child: BlocBuilder<RegisterCubit, RegisterState>(
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
                  'Create your Account',
                  style: TextStyles.font22Black700Weight,
                ),
                const VerticalSpace(40),
                const RegisterForm(),
                const VerticalSpace(40),
                AppTextButton(
                  buttonText: 'Sign Up',
                  onPressed: () =>
                      registerCubit.validateRegisterControllersThenSend(),
                ),
                const VerticalSpace(20),
                const DividerWidget(title: 'Have account?'),
                const VerticalSpace(20),
                AppElevatedTextedButton(
                  buttonText: 'Sign In',
                  onPressed: () => context.go(Routes.loginScreen),
                ),
                const RegisterBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
