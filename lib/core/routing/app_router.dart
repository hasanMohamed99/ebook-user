import 'package:ebook_task_user/features/home/logic/home_cubit.dart';
import 'package:ebook_task_user/features/home/ui/screens/home_screen.dart';
import 'package:ebook_task_user/features/register/logic/register_cubit.dart';
import 'package:ebook_task_user/features/register/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/login/ui/screens/login_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: Routes.loginScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
              child: BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
            ),
    ),
    GoRoute(
      path: Routes.registerScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
              child: BlocProvider(
                create: (context) => getIt<RegisterCubit>(),
                child: const RegisterScreen(),
              ),
            ),
    ),
    GoRoute(
      path: Routes.homeScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<LoginCubit>()),
                  BlocProvider(create: (context) => getIt<HomeCubit>()..getBooks()..getUserStatus()),
                ],
                child: const HomeScreen(),
              ),
            ),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text("No route define for this route"),
    ),
  ),
  initialLocation: getIt<LoginCubit>().isSignIn()?Routes.homeScreen:Routes.loginScreen,
);
