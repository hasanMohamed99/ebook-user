import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  Stream<void> getBooks() {
    try {
      _homeRepo.getBooks().forEach((element) {
        emit(HomeState.success(element));
      });
    } on SocketException catch (error) {
      emit(HomeState.error(message: error.message));
    } on AuthException catch (error) {
      emit(HomeState.error(message: error.message));
    } on Exception catch (error) {
      emit(HomeState.error(message: error.toString()));
    } catch (error) {
      emit(HomeState.error(message: error.toString()));
    }
    return _homeRepo.getBooks();
  }

  Future<void> launchLink(String link) async => await launchUrl(Uri.parse(link));

  late String userStatus = '';

  Future<void> getUserStatus() async{
    userStatus = await _homeRepo.getUserStatus(getUserEmail()??'').then((value) => userStatus = value[0]['status']);
    emit(const HomeState.success(''));
  }

  String? getUserEmail(){
    return _homeRepo.getUserEmail();
  }
}
