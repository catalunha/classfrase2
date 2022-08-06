import 'package:classfrase/app/data/repositories/user_repository.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/domain/usecases/user/user/user_usecase.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository _repository;
  UserUseCaseImpl({
    required UserRepository repository,
  }) : _repository = repository;

  @override
  Future<List<UserModel>> list() async => await _repository.list();

  @override
  Future<UserModel?> readByEmail(String email) async =>
      await _repository.readByEmail(email);
}
