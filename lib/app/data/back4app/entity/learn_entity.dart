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
      person: UserEntity().fromParse(parseObject.get('person') as ParseUser),
    );
    return model;
  }

  Future<ParseObject> toParse(LearnModel model) async {
    final parseObject = ParseObject(LearnEntity.className);
    try {
      print('//+++ ParseObject');
      // if (model.id != null) {
      //   parseObject.objectId = model.id;
      // }
      print('personId ${model.person.id}');
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set('person',
          (ParseObject('_User')..objectId = model.person.id).toPointer());
      // parseObject.set(
      //     'person', ParseObject('_User')..objectId = model.person.id); //error
      print('parseObject $parseObject');
      print('//--- ParseObject');
    } on Exception catch (e) {
      print('//+++ ParseObject error');
      print(e);
      print('//--- ParseObject error');
    }
    // await toParse1(model);
    // await toParse2(model);
    // await toParse3(model);
    // // toParse4(model);
    // await toParse5(model);
    return parseObject;
  }

  // void toParse0(LearnModel model) async {
  //   print('//+++ ParseObject 0');
  //   final parseObject = ParseObject(LearnEntity.className);
  //   if (model.id != null) {
  //     parseObject.objectId = model.id;
  //   }
  //   print('personId ${model.person.id}');
  //   parseObject.set('user', (await ParseUser.currentUser()));
  //   parseObject.set('person', (await ParseUser.currentUser())); //error
  //   // parseObject.set('person', model.person.id); // error
  //   // parseObject.set(
  //   //     'person', ParseObject('_User')..objectId = model.person.id); //error
  //   // parseObject.set('person', ParseObject('User')..objectId = model.person.id); //error
  //   // parseObject.set('person',
  //   //     ParseObject('_User') as ParseUser..objectId = model.person.id);//error

  //   // const pointer = ParseObject('_User').createWithoutData(model.id);//error
  //   // parseObject.set("person", pointer); //error
  //   // parseObject.set('person',
  //   //     (ParseObject('_User')..objectId = model.person.id).toPointer());
  //   print('parseObject $parseObject');
  //   print('//--- ParseObject 0');
  // }

  Future<void> toParse0(LearnModel model) async {
    print('//+++ ParseObject 0');
    try {
      final parseObject = ParseObject(LearnEntity.className);
      if (model.id != null) {
        parseObject.objectId = model.id;
      }
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set('person', (await ParseUser.currentUser())); //error
      print('parseObject $parseObject');
    } on Exception catch (e) {
      print(e);
    }
    print('//--- ParseObject 0');
  }

  Future<void> toParse1(LearnModel model) async {
    print('//+++ ParseObject 1');
    try {
      final parseObject = ParseObject(LearnEntity.className);
      if (model.id != null) {
        parseObject.objectId = model.id;
      }
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set('person', model.person.id); // error
      print('parseObject $parseObject');
    } on Exception catch (e) {
      print(e);
    }
    print('//--- ParseObject 1');
  }

  Future<void> toParse2(LearnModel model) async {
    print('//+++ ParseObject 2');
    try {
      final parseObject = ParseObject(LearnEntity.className);
      if (model.id != null) {
        parseObject.objectId = model.id;
      }
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set(
          'person', ParseObject('_User')..objectId = model.person.id); //error

      print('parseObject $parseObject');
    } on Exception catch (e) {
      print(e);
    }
    print('//--- ParseObject 2');
  }

  Future<void> toParse3(LearnModel model) async {
    print('//+++ ParseObject 3');
    try {
      final parseObject = ParseObject(LearnEntity.className);
      if (model.id != null) {
        parseObject.objectId = model.id;
      }
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set(
          'person', ParseObject('User')..objectId = model.person.id); //error
      print('parseObject $parseObject');
    } on Exception catch (e) {
      print(e);
    }
    print('//--- ParseObject 3');
  }

  Future<void> toParse4(LearnModel model) async {
    print('//+++ ParseObject 4');
    try {
      final parseObject = ParseObject(LearnEntity.className);
      if (model.id != null) {
        parseObject.objectId = model.id;
      }
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set(
          'person',
          ParseObject('_User') as ParseUser
            ..objectId = model.person.id); //error
      //type 'ParseObject' is not a subtype of type 'ParseUser' in type cast
      print('parseObject $parseObject');
    } on Exception catch (e) {
      print(e);
    }
    print('//--- ParseObject 4');
  }

  Future<void> toParse5(LearnModel model) async {
    print('//+++ ParseObject 5');
    try {
      final parseObject = ParseObject(LearnEntity.className);
      if (model.id != null) {
        parseObject.objectId = model.id;
      }
      parseObject.set('user', (await ParseUser.currentUser()));
      parseObject.set('person',
          (ParseObject('_User')..objectId = model.person.id).toPointer());
      print('parseObject $parseObject');
    } on Exception catch (e) {
      print(e);
    }
    print('//--- ParseObject 5');
  }
}
