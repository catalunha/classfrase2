import 'package:classfrase/app/data/back4app/entity/user_entity.dart';
import 'package:classfrase/app/domain/models/learn_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LearnEntity {
  static const String className = 'Learn';
  LearnModel fromParse(ParseObject parseObject) {
    print('LearnEntity: ${parseObject.objectId}');

    LearnModel model = LearnModel(
      id: parseObject.objectId!,
      user: UserEntity().fromParse(parseObject.get('user') as ParseUser),
      folder: parseObject.get<String>('folder') ?? '/',
      person: UserEntity().fromParse(parseObject.get('person') as ParseUser),
      isDeleted: parseObject.get<bool>('isDeleted') ?? false,
    );
    return model;
  }

  Future<ParseObject> toParse(LearnModel model) async {
    final parseObject = ParseObject(LearnEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    print('personId ${model.person.id}');
    parseObject.set('user', (await ParseUser.currentUser()));
    parseObject.set('person', (await ParseUser.currentUser()));
    parseObject.set('folder', model.folder);
    // parseObject.set('person', model.person.id); // error
    parseObject.set('person', ParseObject('_User')..objectId = model.person.id);
    // parseObject.set('person', ParseObject('User')..objectId = model.person.id); //error
    // parseObject.set('person',
    //     ParseObject('_User') as ParseUser..objectId = model.person.id);//error

    parseObject.set('isDeleted', model.isDeleted);
    print('===> $parseObject');
    return parseObject;
  }
}
