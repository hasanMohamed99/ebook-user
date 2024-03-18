import '../../../../core/networking/supabase_service/supabase_service.dart';

class HomeRepo {
  final SupabaseService _supabaseService;
  HomeRepo(this._supabaseService);

  Stream<dynamic> getBooks (){
    return _supabaseService.getBooks();
  }
  Future<List<Map<String, dynamic>>> getUserStatus(String email) async {
    return await _supabaseService.getUserStatus(email);
  }

  String? getUserEmail() {
    return _supabaseService.getUserEmail();
  }
}
