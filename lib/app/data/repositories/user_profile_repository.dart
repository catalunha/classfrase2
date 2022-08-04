import 'package:classfrase/app/domain/models/user_profile_model.dart';

abstract class UserProfileRepository {
  Future<String> create(UserProfileModel userProfileModel);
  Future<String> update(UserProfileModel userProfileModel);
}
