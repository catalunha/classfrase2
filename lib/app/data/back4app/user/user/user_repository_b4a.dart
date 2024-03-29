import 'package:classfrase/app/data/back4app/entity/user_entity.dart';
import 'package:classfrase/app/data/back4app/user/user/user_repository_exception.dart';
import 'package:classfrase/app/data/repositories/user_repository.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepositoryB4a extends GetxService implements UserRepository {
  @override
  Future<List<UserModel>> list() async {
    return [];
  }

  @override
  Future<UserModel?> readByEmail(String email) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseUser.forQuery());
    query.whereEqualTo('email', email);
    query.first();
    final ParseResponse response;
    try {
      response = await query.query();
    } catch (e) {
      throw UserRepositoryException(
          code: '123', message: 'Erro ao buscar user');
    }
    UserModel? temp;
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        //print(element as ParseObject).objectId);
        temp = UserEntity().fromParse(element as ParseUser);
      }
      //printtemp);
      return temp;
    } else {
      //print'nao encontrei este User...');
      return null;
    }
  }
}
