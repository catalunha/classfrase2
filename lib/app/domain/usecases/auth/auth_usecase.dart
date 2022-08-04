import 'package:classfrase/app/domain/models/user_model.dart';

abstract class AuthUseCase {
  Future<UserModel?> registerEmail(
      {required String email, required String password});
  Future<UserModel?> loginEmail(
      {required String email, required String password});
  Future<void> forgotPassword(String email);

  Future<bool> logout();
}
