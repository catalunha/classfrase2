import 'package:classfrase/app/presentation/controllers/auth/email/auth_register_email_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/auth/login/login_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/auth/splash/splash_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/home/home_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/phrase/phrase_dependecies.dart';
import 'package:classfrase/app/presentation/controllers/user/profile/user_profile_dependencies.dart';
import 'package:classfrase/app/presentation/views/auth/login/auth_login_page.dart';
import 'package:classfrase/app/presentation/views/auth/register/email/auth_register_email.page.dart';
import 'package:classfrase/app/presentation/views/auth/splash/splash_page.dart';
import 'package:classfrase/app/presentation/views/home/home_page.dart';
import 'package:classfrase/app/presentation/views/phrase/add_edit/phrase_addedit_page.dart';
import 'package:classfrase/app/presentation/views/phrase/list/phrase_archived_page.dart';
import 'package:classfrase/app/presentation/views/user/profile/user_profile_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';

  static const authLogin = '/auth/login';
  static const authRegisterEmail = '/auth/register/email';

  static const home = '/home';
  static const userProfile = '/user/profile';

  static const phraseAddEdit = '/phrase/addedit';
  static const phraseArchived = '/phrase/archived';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authRegisterEmail,
      binding: AuthRegisterEmailDependencies(),
      page: () => AuthRegisterEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      bindings: [HomeDependencies(), PhraseDependencies()],
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.userProfile,
      binding: UserProfileDependencies(),
      page: () => UserProfilePage(),
    ),
    GetPage(
      name: Routes.phraseAddEdit,
      binding: PhraseDependencies(),
      page: () => PhraseAddEditPage(),
    ),
    GetPage(
      name: Routes.phraseArchived,
      binding: PhraseDependencies(),
      page: () => PhraseArchivedPage(),
    ),
  ];
}
