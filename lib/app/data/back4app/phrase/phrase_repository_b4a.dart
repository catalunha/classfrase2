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

  @override
  Future<void> onChangeClassOrder(String id, List<String> classOrder) async {
    var parseObject = ParseObject(PhraseEntity.className)..objectId = id;
    parseObject.set('classOrder', classOrder);
    await parseObject.save();
  }

  @override
  Future<void> onSaveClassification(
      String id,
      Map<String, Classification> classifications,
      List<String> classOrder) async {
    var parseObject = ParseObject(PhraseEntity.className)..objectId = id;
    var data = <String, dynamic>{};
    for (var item in classifications.entries) {
      data[item.key] = item.value.toMap();
    }
    print('data: $data');
    parseObject.set('classifications', data);
    parseObject.set('classOrder', classOrder);
    await parseObject.save();
  }

  @override
  Future<PhraseModel?> read(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(PhraseEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject(['user', 'user.profile']);
    query.first();
    final ParseResponse response = await query.query();
    PhraseModel? temp;
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        // print((element as ParseObject).objectId);
        temp = PhraseEntity().fromParse(element);
      }
      // return listTemp;
    } else {
      print('nao encontrei esta Phrase...');
      // return [];
    }
    return temp;
  }
}
