import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String name;
  final String email;
  final String status;
  final String password;

  RegisterRequestBody({
    required this.name,
    required this.email,
    required this.status,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
