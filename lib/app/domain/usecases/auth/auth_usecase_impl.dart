import 'dart:async';

import 'package:classfrase/app/data/repositories/auth_repository.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/domain/usecases/auth/auth_usecase.dart';

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
  @override
  Future<UserModel?> registerEmail(
          {required String email, required String password}) =>
      _authRepository.registerEmail(email: email, password: password);

  @override
  Future<UserModel?> loginEmail(
          {required String email, required String password}) =>
      _authRepository.loginEmail(email: email, password: password);

  @override
  Future<void> forgotPassword(String email) =>
      _authRepository.forgotPassword(email);

  @override
  Future<bool> logout() => _authRepository.logout();
}
