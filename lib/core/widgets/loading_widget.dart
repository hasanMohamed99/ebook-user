import 'package:ebook_task_user/core/theming/colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(color: AppColors.mainYellow);
  }
}
