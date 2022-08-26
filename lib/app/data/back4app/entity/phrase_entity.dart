import 'package:classfrase/app/data/back4app/entity/user_entity.dart';
import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PhraseEntity {
  static const String className = 'Phrase';
  PhraseModel fromParse(ParseObject parseObject) {
    //print'PhraseEntity: ${parseObject.objectId}');

    Map<String, Classification>? classifications = <String, Classification>{};
    Map<String, dynamic>? tempClass =
        parseObject.get<Map<String, dynamic>>('classifications');
    if (tempClass != null) {
      for (var item in tempClass.entries) {
        classifications[item.key] = Classification.fromMap(item.value);
      }
    }
    //printtempClass);
    //printclassifications);
    PhraseModel model = PhraseModel(
      id: parseObject.objectId!,
      user: UserEntity().fromParse(parseObject.get('user') as ParseUser),
      phrase: parseObject.get<String>('phrase')!,
      phraseList: parseObject
          .get<List<dynamic>>('phraseList')!
          .map((e) => e.toString())
          .toList(),
      classifications: classifications,
      classOrder: parseObject
          .get<List<dynamic>>('classOrder')!
          .map((e) => e.toString())
          .toList(),
      folder: parseObject.get<String>('folder') ?? '/',
      font: parseObject.get<String>('font'),
      diagramUrl: parseObject.get<String>('diagramUrl'),
      isArchived: parseObject.get<bool>('isArchived') ?? false,
      isPublic: parseObject.get<bool>('isPublic') ?? false,
      isDeleted: parseObject.get<bool>('isDeleted') ?? false,
    );
    return model;
  }

  Future<ParseObject> toParse(PhraseModel model) async {
    final parseObject = ParseObject(PhraseEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    parseObject.set('user', currentUser);
    parseObject.set('phrase', model.phrase);
    parseObject.set('phraseList', model.phraseList);
    var data = <String, dynamic>{};
    for (var item in model.classifications.entries) {
      data[item.key] = item.value.toMap();
    }
    parseObject.set('classifications', data);
    parseObject.set('classOrder', model.classOrder);
    parseObject.set('folder', model.folder);
    parseObject.set('font', model.font);
    parseObject.set('folder', model.folder);
    parseObject.set('diagramUrl', model.diagramUrl);
    parseObject.set('isArchived', model.isArchived);
    parseObject.set('isDeleted', model.isDeleted);
    parseObject.set('isPublic', model.isPublic);

    return parseObject;
  }
}
