import 'dart:io';

import 'package:ebook_task_user/features/register/data/models/register_request_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register_state.dart';
import '../data/repo/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;
  RegisterCubit(this._registerRepo) : super(const RegisterState.initial());

  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  void validateRegisterControllersThenSend() {
    if (registerFormKey.currentState!.validate()) {
      _emitRegisterStates(
        registerRequestBody: RegisterRequestBody(
          name: registerNameController.text,
          email: registerEmailController.text,
          password: registerPasswordController.text,
          status: 'pending',
        ),
      );
    }
  }

  void _emitRegisterStates(
      {required RegisterRequestBody registerRequestBody}) async {
    emit(const RegisterState.loading());
    try {
      await _registerRepo
          .register(registerRequestBody: registerRequestBody)
          .then((value) async{
        await _registerRepo
            .addUserToDatabase(
                registerRequestBody: registerRequestBody, id: value.user!.id)
            .then((value) =>
                emit(const RegisterState.success('Register Success')));
      });
    } on PostgrestException catch (error) {
      emit(RegisterState.error(message: error.details.toString()));
    } on SocketException catch (error) {
      emit(RegisterState.error(message: error.message));
    } on AuthException catch (error) {
      emit(RegisterState.error(message: error.message));
    } on Exception catch (error) {
      emit(RegisterState.error(message: error.toString()));
    } catch (error) {
      emit(RegisterState.error(message: error.toString()));
    }
  }
}
