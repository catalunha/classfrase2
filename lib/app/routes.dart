import 'package:classfrase/app/presentation/controllers/auth/email/auth_register_email_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/auth/login/login_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/auth/splash/splash_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/classifying/classifying_dependecies.dart';
import 'package:classfrase/app/presentation/controllers/home/home_dependencies.dart';
import 'package:classfrase/app/presentation/controllers/learn/learn_dependecies.dart';
import 'package:classfrase/app/presentation/controllers/pdf/pdf_dependecies.dart';
import 'package:classfrase/app/presentation/controllers/phrase/phrase_dependecies.dart';
import 'package:classfrase/app/presentation/controllers/user/profile/user_profile_dependencies.dart';
import 'package:classfrase/app/presentation/services/classification/classification_depedencies.dart';
import 'package:classfrase/app/presentation/views/auth/login/auth_login_page.dart';
import 'package:classfrase/app/presentation/views/auth/register/email/auth_register_email.page.dart';
import 'package:classfrase/app/presentation/views/auth/splash/splash_page.dart';
import 'package:classfrase/app/presentation/views/classifying/categories_page.dart';
import 'package:classfrase/app/presentation/views/classifying/classifying_page.dart';
import 'package:classfrase/app/presentation/views/home/home_page.dart';
import 'package:classfrase/app/presentation/views/learn/list/categories_by_person_page.dart';
import 'package:classfrase/app/presentation/views/learn/list/learn_list_page.dart';
import 'package:classfrase/app/presentation/views/learn/list/person_phrase_list_page.dart';
import 'package:classfrase/app/presentation/views/learn/person_phrase_page.dart';
import 'package:classfrase/app/presentation/views/pdf/pdf_all_page.dart';
import 'package:classfrase/app/presentation/views/pdf/pdf_page.dart';
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
  static const phraseClassifying = '/phrase/classifying';
  static const phraseCategoryGroup = '/phrase/category_group';

  static const learnList = '/learn/list';
  static const learnPersonPhraseList = '/learn/person/phrase/list';
  static const learnPersonPhrase = '/learn/person/phrase';
  static const learnCategoriesByPerson = '/learn/categories/person';

  static const pdf = '/pdf';
  static const pdfAll = '/pdf/all';

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
      bindings: [
        HomeDependencies(),
        PhraseDependencies(),
        ClassificationDependencies(),
      ],
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
    GetPage(
      name: Routes.phraseClassifying,
      binding: ClassifyingDependencies(),
      page: () => ClassifyingPage(),
    ),
    GetPage(
      name: Routes.phraseCategoryGroup,
      binding: ClassifyingDependencies(),
      page: () => CategoriesPage(),
    ),
    GetPage(
      name: Routes.learnList,
      binding: LearnDependencies(),
      page: () => LearnListPage(),
    ),
    GetPage(
      name: Routes.learnPersonPhraseList,
      binding: LearnDependencies(),
      page: () => PersonPhraseListPage(),
    ),
    GetPage(
      name: Routes.learnPersonPhrase,
      binding: LearnDependencies(),
      page: () => PersonPhrasePage(),
    ),
    GetPage(
      name: Routes.pdf,
      binding: PdfDependencies(),
      page: () => PdfPage(),
    ),
    GetPage(
      name: Routes.pdfAll,
      // binding: PdfDependencies(),
      page: () => PdfAllPage(),
    ),
    GetPage(
      name: Routes.learnCategoriesByPerson,
      page: () => CategoriesByPersonPage(),
    ),
  ];
}
