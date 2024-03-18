import 'package:ebook_task_user/features/register/data/models/register_request_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/networking/supabase_service/supabase_service.dart';

class RegisterRepo {
  final SupabaseService _supabaseService;
  RegisterRepo(this._supabaseService);

  Future<AuthResponse> register({required RegisterRequestBody registerRequestBody}) async =>
      await _supabaseService.register(registerRequestBody: registerRequestBody);
  Future<void> addUserToDatabase({required RegisterRequestBody registerRequestBody, required String id }) async =>
      await _supabaseService.addUserToDatabase(registerRequestBody: registerRequestBody, id: id);
}
