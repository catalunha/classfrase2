import 'dart:developer';

import 'package:classfrase/app/data/back4app/learn/learn_repository_exception.dart';
import 'package:classfrase/app/data/back4app/user/user/user_repository_exception.dart';
import 'package:classfrase/app/domain/models/learn_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/domain/usecases/learn/learn_usecase.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/domain/usecases/user/user/user_usecase.dart';
import 'package:classfrase/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/routes.dart';
import 'package:get/get.dart';

class LearnController extends GetxController with LoaderMixin, MessageMixin {
  final LearnUseCase _learnUseCase;
  final UserUseCase _userUseCase;
  final PhraseUseCase _phraseUseCase;

  LearnController(
      {required LearnUseCase learnUseCase,
      required UserUseCase userUseCase,
      required PhraseUseCase phraseUseCase})
      : _learnUseCase = learnUseCase,
        _phraseUseCase = phraseUseCase,
        _userUseCase = userUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _learnList = <LearnModel>[].obs;
  List<LearnModel> get learnList => _learnList;

  final _person = Rxn<UserModel>();
  UserModel get person => _person.value!;

  final _personPhraseList = <PhraseModel>[].obs;
  List<PhraseModel> get personPhraseList => _personPhraseList;

  final _personPhrase = Rxn<PhraseModel>();
  PhraseModel? get personPhrase => _personPhrase.value;

  @override
  void onInit() async {
    print('+++ init learn');
    loaderListener(_loading);
    messageListener(_message);
    await listAll();
    super.onInit();
    print('--- init learn');
  }

  Future<void> listAll() async {
    _learnList.clear();
    List<LearnModel> temp = await _learnUseCase.list();
    _learnList(temp);
  }

  Future<void> add({
    required String email,
    String folder = '/',
  }) async {
    print('add $email');
    try {
      Get.back();
      _loading(true);
      UserModel userModel;
      SplashController splashController = Get.find();
      userModel = splashController.userModel!;
      log('buscando $email');
      UserModel? person = await _userUseCase.readByEmail(email);
      if (person != null) {
        log('pessoa encontrada ${person.id}');
        LearnModel model = LearnModel(
          user: userModel,
          folder: folder,
          person: person,
        );
        log(model.toString());
        await _learnUseCase.append(model);
      } else {
        log('nao achei nenhuma pessoa com este email');
        throw Exception();
      }
    } on UserRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops em User',
        message: e.message,
        isError: true,
      );
    } on LearnRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops em Learn',
        message: e.message,
        isError: true,
      );
    } catch (e) {
      // Get.back();
      log('catch');
      _loading(false);

      _message.value = MessageModel(
        title: 'Oops',
        message: 'Nao achei nenhuma pessoa com este email',
        isError: true,
      );
    } finally {
      listAll();
      _loading(false);
    }
  }

  void selectPerson(String learnId) async {
    print('learnId : $learnId');
    var phraseTemp = _learnList.firstWhere((element) => element.id == learnId);
    _person(phraseTemp.person);
    await listPhraseThisPerson(person.id);
    Get.toNamed(Routes.learnPersonPhraseList);
  }

  Future<void> listPhraseThisPerson(String personId) async {
    _personPhraseList.clear();
    List<PhraseModel> temp = await _phraseUseCase.listThisPerson(personId);
    _personPhraseList(temp);
  }

  void selectPhrase(String phraseId) async {
    PhraseModel? temp = await _phraseUseCase.read(phraseId);
    _personPhrase(temp);
    Get.toNamed(Routes.learnPersonPhrase);
  }
}
