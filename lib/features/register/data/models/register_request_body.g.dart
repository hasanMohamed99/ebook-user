// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBody _$RegisterRequestBodyFromJson(Map<String, dynamic> json) =>
    RegisterRequestBody(
      name: json['name'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterRequestBodyToJson(
        RegisterRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
      'password': instance.password,
    };
