import 'package:classfrase/app/domain/models/user_profile_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserProfileEntity {
  static const String className = 'UserProfile';

  UserProfileModel fromParse(ParseObject parseObject) {
    UserProfileModel userProfileEntity = UserProfileModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      description: parseObject.get('description'),
      phone: parseObject.get('phone'),
      community: parseObject.get('community'),
      photo: parseObject.get('photo')?.get('url'),
      email: parseObject.get('email'),
      isActive: parseObject.get('isActive'),
    );
    return userProfileEntity;
  }

  Future<ParseObject> toParse(UserProfileModel userProfileModel) async {
    final profileParse = ParseObject(UserProfileEntity.className);
    if (userProfileModel.id != null) {
      profileParse.objectId = userProfileModel.id;
    }
    if (userProfileModel.name != null) {
      profileParse.set('name', userProfileModel.name);
    }
    if (userProfileModel.description != null) {
      profileParse.set('description', userProfileModel.description);
    }
    if (userProfileModel.phone != null) {
      profileParse.set('phone', userProfileModel.phone);
    }
    if (userProfileModel.community != null) {
      profileParse.set('community', userProfileModel.community);
    }
    // if (userProfileModel.photoParseFileBase != null) {
    //   profileParse.set('photo', userProfileModel.photoParseFileBase);
    // }
    if (userProfileModel.email != null) {
      profileParse.set('email', userProfileModel.email);
    }
    if (userProfileModel.isActive != null) {
      profileParse.set('isActive', userProfileModel.isActive);
    }
    return profileParse;
  }
}
