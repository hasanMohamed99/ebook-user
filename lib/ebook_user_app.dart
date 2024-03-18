import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theming/colors.dart';

class EbookUserApp extends StatelessWidget {
  const EbookUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mainYellow,
          primary: AppColors.mainYellow,
          secondary: AppColors.mainYellow,
        ),
        scaffoldBackgroundColor: AppColors.gray,
        splashColor: Colors.transparent,
      ),
    );
  }
}
