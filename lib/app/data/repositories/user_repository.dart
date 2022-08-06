import 'package:classfrase/app/domain/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> list();
  Future<UserModel?> readByEmail(String email);
}
