import 'package:classfrase/app/data/back4app/entity/learn_entity.dart';
import 'package:classfrase/app/data/back4app/learn/learn_repository_exception.dart';
import 'package:classfrase/app/data/repositories/learn_repository.dart';
import 'package:classfrase/app/domain/models/learn_model.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LearnRepositoryB4a extends GetxService implements LearnRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(LearnEntity.className));
    var currentUser = await ParseUser.currentUser() as ParseUser?;

    query.whereEqualTo('user', currentUser);
    query.orderByAscending('user.profile.email');
    query.includeObject(['user', 'user.profile', 'person', 'person.profile']);
    return query;
  }

  @override
  Future<List<LearnModel>> list() async {
    QueryBuilder<ParseObject> query = await getQueryAll();

    final ParseResponse response = await query.query();
    List<LearnModel> listTemp = <LearnModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        //print(element as ParseObject).objectId);
        listTemp.add(LearnEntity().fromParse(element));
      }
      return listTemp;
    } else {
      //print'Sem Learns...');
      return [];
    }
  }

  @override
  Future<String> append(LearnModel model) async {
    try {
      final ParseObject parseObject = await LearnEntity().toParse(model);
      final ParseResponse parseResponse = await parseObject.save();
      if (parseResponse.success && parseResponse.results != null) {
        ParseObject userProfile = parseResponse.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw LearnRepositoryException(
            code: 1, message: 'Não foi possivel cadastrar/atualizar o bem.');
      }
    } catch (e) {
      //print'+++ print error em append');
      //printe);
      //print'--- print error em append');
      throw LearnRepositoryException(
          code: 1, message: 'Erro ao cadastrar learn');
    }
  }

  @override
  Future<void> delete(String id) async {
    var parseObject = ParseObject(LearnEntity.className)..objectId = id;
    await parseObject.delete();
  }
}
