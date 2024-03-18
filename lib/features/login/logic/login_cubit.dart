import 'dart:io';
import 'package:ebook_task_user/features/login/data/models/login_request_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/repos/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void validateLoginControllersThenSend() {
    if (formKey.currentState!.validate()) {
      _emitLoginStates(
        loginRequestBody: LoginRequestBody(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  void _emitLoginStates(
      {required LoginRequestBody loginRequestBody}) async {
    emit(const LoginState.loading());
    try {
      await _loginRepo.login(loginRequestBody: loginRequestBody).then((value) => emit(const LoginState.success('Successfully logged in')));
    } on SocketException catch (error) {
      emit(LoginState.error(message: error.message));
    } on AuthException catch (error) {
      emit(LoginState.error(message: error.message));
    } on Exception catch (error) {
      emit(LoginState.error(message: error.toString()));
    } catch (error) {
      emit(LoginState.error(message: error.toString()));
    }
  }

  bool isSignIn() {
    try {
      _loginRepo.isSignIn()
          ? emit(const LoginState<String>.success('User SignIn'))
          : null;
      return _loginRepo.isSignIn();
    } on SocketException catch (error) {
      emit(LoginState.error(message: error.message));
      return false;
    } on Exception catch (error) {
      emit(LoginState.error(message: error.toString()));
      return false;
    } catch (error) {
      emit(LoginState.error(message: error.toString()));
      return false;
    }
  }

  Future<void> logout() async {
    emit(const LoginState.loading());
    try {
      await _loginRepo.logout().then((value) => emit(const LoginState<bool>.success(true)));
    } on SocketException catch (error) {
      emit(LoginState.error(message: error.message));
    } on AuthException catch (error) {
      emit(LoginState.error(message: error.message));
    } on Exception catch (error) {
      emit(LoginState.error(message: error.toString()));
    } catch (error) {
      emit(LoginState.error(message: error.toString()));
    }
  }
}
