import 'package:ebook_task_user/core/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'ebook_user_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/dependency_injection.dart';
import 'core/helpers/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    ).then((value) => setupGetIt()),
  ]);

  Bloc.observer = MyBlocObserver();
  runApp(const EbookUserApp());
}