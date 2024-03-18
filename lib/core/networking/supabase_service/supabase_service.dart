import 'package:ebook_task_user/features/login/data/models/login_request_body.dart';
import 'package:ebook_task_user/features/register/data/models/register_request_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../helpers/constants.dart';

class SupabaseService {
  final Supabase supabase;
  const SupabaseService(this.supabase);

  Future<AuthResponse> register({
    required RegisterRequestBody registerRequestBody,
  }) async =>
      await supabase.client.auth.signUp(
        email: registerRequestBody.email,
        password: registerRequestBody.password,
      );

  Future<void> addUserToDatabase({required RegisterRequestBody registerRequestBody, required String id }) async =>
    await supabase.client.from(DatabaseConstants.kUsersTable).insert(
      {
        'email': registerRequestBody.email,
        'status': registerRequestBody.status,
        'name': registerRequestBody.name,
        'auth_id': id,
      },
    );


  Future<AuthResponse> login({
    required LoginRequestBody loginRequestBody,
  }) async =>
      await supabase.client.auth.signInWithPassword(
        email: loginRequestBody.email,
        password: loginRequestBody.password,
      );

  bool isSignIn() {
    return supabase.client.auth.currentSession != null ? true : false;
  }

  Future<void> logout() async {
    await supabase.client.auth.signOut();
  }

  Stream<dynamic> getBooks() {
    return supabase.client.from('books').stream(primaryKey: ['id']);
  }

  String? getUserEmail() {
    return supabase.client.auth.currentUser?.email;
  }

  Future<List<Map<String, dynamic>>> getUserStatus(String email) async {
    return await supabase.client
        .from('users')
        .select('status')
        .match({'email': email});
  }
}
