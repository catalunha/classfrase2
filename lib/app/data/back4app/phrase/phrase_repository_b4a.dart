import 'package:classfrase/app/data/back4app/entity/phrase_entity.dart';
import 'package:classfrase/app/data/back4app/enum/phrase_enum.dart';
import 'package:classfrase/app/data/back4app/phrase/phrase_repository_exception.dart';
import 'package:classfrase/app/data/repositories/phrase_repository.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PhraseRepositoryB4a extends GetxService implements PhraseRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PhraseEntity.className));
    query.whereEqualTo('isArchived', false);
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('folder');
    query.includeObject(['user', 'user.profile']);
    return query;
  }

  Future<QueryBuilder<ParseObject>> getQueryArchived() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PhraseEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.whereEqualTo('isArchived', true);
    query.orderByAscending('folder');
    query.includeObject(['user', 'user.profile']);
    return query;
  }

  @override
  Future<List<PhraseModel>> list(GetQueryFilterPhrase queryType) async {
    QueryBuilder<ParseObject> query;
    if (queryType == GetQueryFilterPhrase.archived) {
      query = await getQueryArchived();
    } else {
      query = await getQueryAll();
    }

    final ParseResponse response = await query.query();
    List<PhraseModel> listTemp = <PhraseModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        print((element as ParseObject).objectId);
        listTemp.add(PhraseEntity().fromParse(element));
      }
      return listTemp;
    } else {
      print('Sem Phrases...');
      return [];
    }
  }

  @override
  Future<String> append(PhraseModel model) async {
    final parseObject = await PhraseEntity().toParse(model);
    final ParseResponse parseResponse = await parseObject.save();
    if (parseResponse.success && parseResponse.results != null) {
      ParseObject userProfile = parseResponse.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      throw PhraseRepositoryException(
          code: 1, message: 'Não foi possivel cadastrar/atualizar o bem.');
    }
  }

  @override
  Future<void> delete(String id) async {
    var parseObject = ParseObject(PhraseEntity.className)..objectId = id;
    await parseObject.delete();
  }

  @override
  Future<void> isArchive(String id, bool mode) async {
    var parseObject = ParseObject(PhraseEntity.className)..objectId = id;
    parseObject.set('isArchived', mode);
    await parseObject.save();
  }
}
