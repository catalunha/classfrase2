import 'package:classfrase/app/data/back4app/entity/user_profile_entity.dart';
import 'package:classfrase/app/data/back4app/init_back4app.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/domain/models/user_profile_model.dart';
import 'package:classfrase/app/domain/usecases/auth/auth_usecase.dart';
import 'package:classfrase/app/routes.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SplashController extends GetxController {
  final AuthUseCase _authUseCase;
  SplashController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  final Rxn<ParseUser> _parseUser = Rxn<ParseUser>();
  ParseUser? get parseUser => _parseUser.value;
  set parseUser(ParseUser? parseUser) {
    _parseUser(parseUser);
  }

  final _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;
  set userModel(UserModel? userModel) {
    _userModel(userModel);
    _userModel.update((val) {
      val?.profile = userModel?.profile;
      // if (userModel?.profile != null) {
      // }
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1), () {
      // deleayed code here
      print('delayed execution');
    });

    print('+++ initParse');
    InitBack4app initBack4app = InitBack4app();
    bool initParse = await initBack4app.init();
    print('initParse: $initParse');
    print('--- initParse');

    final isLogged = await _hasUserLogged();
    if (isLogged) {
      print('tem user indo para home');
      print(userModel);
      if (userModel!.profile!.isActive == true) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.authLogin);
      }
    } else {
      print('NAO tem user indo para LOGIN');
      print(userModel);
      Get.offAllNamed(Routes.authLogin);
    }
  }

  Future<bool> _hasUserLogged() async {
    print('===> _hasUserLogged');
    parseUser = await ParseUser.currentUser() as ParseUser?;
    // ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (parseUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(parseUser!.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await parseUser!.logout();
      return false;
    } else {
      // QueryBuilder<ParseUser> queryUser =
      //     QueryBuilder<ParseUser>(ParseUser.forQuery());
      // queryUser.object = parseUser!;
      // queryUser.includeObject(['profile']);
      // ParseUser? parseUser2 = await queryUser.first();

      // print('===> profile');
      // userModel = UserModel.fromParse(parseUser2!);
      // print(userModel);
      // var profileField = parseUser!.get('profile');
      // print('===> profile');
      // print(profileField);
      // var profileObj = ParseObject('Profile');
      // var profileData = await profileObj.getObject(profileField.objectId);
      // UserProfileEntity? userProfileEntity;
      // if (profileData.success) {
      //   (profileData.result as ParseObject).get('fullName');
      //   userProfileEntity =
      //       UserProfileEntity.fromParse(profileData.result as ParseObject);
      // } else {
      //   print('nao foi');
      // }
      userModel = UserModel(
        id: parseUser!.objectId!,
        email: parseUser!.emailAddress!,
        profile: await getProfile(),
        // profile: userProfileEntity,
      );
      // _userModel(UserModel(
      //   id: parseUser!.objectId!,
      //   email: parseUser!.emailAddress!,
      //   phone: parseUser!.username!,
      //   profile: userProfileEntity,
      // ));
      // updateUserModel(UserModel(
      //   id: parseUser!.objectId!,
      //   email: parseUser!.emailAddress!,
      //   phone: parseUser!.username!,
      //   profile: userProfileEntity,
      // ));
      print('===> _hasUserLogged. userModel');
      print(userModel);
      print('===> isActive');
      print(userModel!.profile!.isActive);
      return true;
    }
  }

  Future<void> updateUserProfile() async {
    print('entrando no updateUserProfile');
    // parseUser = await ParseUser.currentUser() as ParseUser;
    // var profileField = parseUser!.get('profile');
    // print('===> profile');
    // print(profileField);
    // var profileObj = ParseObject('Profile');
    // var profileData = await profileObj.getObject(profileField.objectId);
    // UserProfileEntity? userProfileEntity;
    // if (profileData.success) {
    //   (profileData.result as ParseObject).get('fullName');
    //   userProfileEntity =
    //       UserProfileEntity.fromParse(profileData.result as ParseObject);
    // } else {
    //   print('nao foi');
    // }
    userModel = UserModel(
      id: parseUser!.objectId!,
      email: parseUser!.emailAddress!,
      profile: await getProfile(),
      // profile: userProfileEntity,
    );
    // _userModel(UserModel(
    //   id: parseUser!.objectId!,
    //   email: parseUser!.emailAddress!,
    //   phone: parseUser!.username!,
    //   profile: userProfileEntity,
    // ));
    // updateUserModel(UserModel(
    //   id: parseUser!.objectId!,
    //   email: parseUser!.emailAddress!,
    //   phone: parseUser!.username!,
    //   profile: userProfileEntity,
    // ));
    print('===> user');
    print(userModel);
  }

  Future<UserProfileModel?> getProfile() async {
    parseUser = await ParseUser.currentUser() as ParseUser;

    var profileField = parseUser!.get('profile');
    print('===> profile');
    print(profileField);
    var profileObj = ParseObject(UserProfileEntity.className);
    var profileData = await profileObj.getObject(profileField.objectId);
    UserProfileModel? userProfileEntity;
    if (profileData.success) {
      userProfileEntity =
          UserProfileEntity().fromParse(profileData.result as ParseObject);
    } else {
      print('nao foi');
    }
    return userProfileEntity;
  }

  // Future<void> logout() async => await _authUseCase.logout();

  //   Future<bool> hasUserLogged() async {
  //   ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
  //   if (currentUser == null) {
  //     return false;
  //   }
  //   //Checks whether the user's session token is valid
  //   final ParseResponse? parseResponse =
  //       await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

  //   if (parseResponse?.success == null || !parseResponse!.success) {
  //     //Invalid session. Logout
  //     await currentUser.logout();
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
