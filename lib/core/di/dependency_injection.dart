import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/login/data/repos/login_repo.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/register/data/repo/register_repo.dart';
import '../../features/register/logic/register_cubit.dart';
import '../local/shared_pref_service/shared_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import '../networking/supabase_service/supabase_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async{
  final supabaseInstance = Supabase.instance;
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService(supabaseInstance));

  // Shared Preferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPrefService>(() => SharedPrefService(prefs));

  // Register
  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
  getIt.registerSingleton<RegisterCubit>(RegisterCubit(getIt()));

  // Login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt(),getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // Home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

}