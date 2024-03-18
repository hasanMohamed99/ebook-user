import 'package:ebook_task_user/features/login/data/models/login_request_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/local/shared_pref_service/shared_pref_service.dart';
import '../../../../core/networking/supabase_service/supabase_service.dart';

class LoginRepo {
  final SupabaseService _supabaseService;
  final SharedPrefService _sharedPrefService;

  LoginRepo(this._supabaseService, this._sharedPrefService);

  Future<AuthResponse> login(
          {required LoginRequestBody loginRequestBody}) async =>
      await _supabaseService.login(loginRequestBody: loginRequestBody);

  bool isSignIn() {
    return _supabaseService.isSignIn();
  }

  Future<void> logout() async {
    await _supabaseService.logout();
  }
}
