import 'dart:developer';

import 'package:classfrase/app/data/back4app/learn/learn_repository_exception.dart';
import 'package:classfrase/app/data/back4app/user/user/user_repository_exception.dart';
import 'package:classfrase/app/domain/models/catclass_model.dart';
import 'package:classfrase/app/domain/models/learn_model.dart';
import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/domain/usecases/learn/learn_usecase.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/domain/usecases/user/user/user_usecase.dart';
import 'package:classfrase/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:classfrase/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_treeview/src/primitives/tree_node.dart';
import 'package:get/get.dart';

class LearnController extends GetxController with LoaderMixin, MessageMixin {
  final LearnUseCase _learnUseCase;
  final UserUseCase _userUseCase;
  final PhraseUseCase _phraseUseCase;
  final ClassificationService _classificationService;

  LearnController({
    required LearnUseCase learnUseCase,
    required UserUseCase userUseCase,
    required PhraseUseCase phraseUseCase,
    required ClassificationService classificationService,
  })  : _learnUseCase = learnUseCase,
        _phraseUseCase = phraseUseCase,
        _userUseCase = userUseCase,
        _classificationService = classificationService;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _learnList = <LearnModel>[].obs;
  List<LearnModel> get learnList => _learnList;

  final _person = Rxn<UserModel>();
  UserModel get person => _person.value!;

  final _personPhraseList = <PhraseModel>[].obs;
  List<PhraseModel> get personPhraseList => _personPhraseList;
  final _personPhraseAllList = <PhraseModel>[].obs;
  List<PhraseModel> get personPhraseAllList => _personPhraseAllList;

  final _personPhrase = Rxn<PhraseModel>();
  PhraseModel? get personPhrase => _personPhrase.value;

  final _selectedCategoryIdList = <String>[].obs;
  List<String> get selectedCategoryIdList => _selectedCategoryIdList;

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

  Future<void> selectedLearn(String learnId) async {
    print('learnId : $learnId');
    var phraseTemp = _learnList.firstWhere((element) => element.id == learnId);
    _person(phraseTemp.person);
    await listPhrasesThisPerson(person.id);
  }

  Future<void> listPhrasesThisPerson(String personId) async {
    _personPhraseList.clear();
    List<PhraseModel> temp = await _phraseUseCase.listThisPerson(personId);
    _personPhraseAllList.addAll([...temp]);
    _personPhraseList.addAll([...temp]);
  }

  void selectPhrase(String phraseId) async {
    PhraseModel? temp = await _phraseUseCase.read(phraseId);
    _personPhrase(temp);
    Get.toNamed(Routes.learnPersonPhrase);
  }

  void onDeleteLearn(String id) async {
    await _learnUseCase.delete(id);
    _learnList.removeWhere((element) => element.id == id);
  }

  Future<void> onMarkCategoryIfAlreadyClassified() async {
    _loading(true);
    List<String> categoryIdListTemp = <String>[];
    for (var phrase in _personPhraseList) {
      Map<String, Classification> classifications = phrase.classifications;
      _selectedCategoryIdList.clear();

      for (var classification in classifications.values) {
        categoryIdListTemp.addAll(classification.categoryIdList);
      }
    }
    _selectedCategoryIdList.addAll([
      ...{...categoryIdListTemp}
    ]);
    _loading(false);
    Get.toNamed(Routes.learnCategoriesByPerson);
  }

  void removeFilter() {
    _personPhraseList.clear();
    _personPhraseList([..._personPhraseAllList]);
  }

  void onSelectPhasesByThisCategory(String catClassId) {
    final personPhraseListTemp = <PhraseModel>[];
    personPhraseListTemp.addAll([..._personPhraseList]);
    for (var phrase in personPhraseListTemp) {
      Map<String, Classification> classifications = phrase.classifications;
      bool contain = false;
      for (var classification in classifications.values) {
        if (classification.categoryIdList.contains(catClassId)) {
          contain = true;
        }
      }
      if (!contain) {
        _personPhraseList.removeWhere((element) => element.id == phrase.id);
        print('removendo ${phrase.id}');
      }
    }
    Get.back();
  }

  //tree
  List<TreeNode> createTree() {
    List<TreeNode> treeNodeList = [];
    treeNodeList.clear();
    treeNodeList.add(
      childrenNodes(null),
    );

    return treeNodeList;
  }

  TreeNode childrenNodes(CatClassModel? ngb) {
    List<CatClassModel> sub = [];
    if (ngb == null) {
      sub = _classificationService.category
          .where((element) => element.parent == null)
          .toList();
    } else {
      sub = _classificationService.category
          .where((element) => element.parent == ngb.id)
          .toList();
    }
    CatClassModel ngbTemp =
        ngb ?? CatClassModel(id: '...', name: 'Classificações', filter: []);
    if (sub.isNotEmpty) {
      return TreeNode(
          content: widgetForTree(ngbTemp),
          children: sub.map((e) => childrenNodes(e)).toList());
    }
    return TreeNode(
      content: widgetForTree(ngbTemp),
    );
  }

  Widget widgetForTree(CatClassModel ngbTemp) {
    return InkWell(
        child: Text(
          ngbTemp.name,
          style: TextStyle(
              color: _selectedCategoryIdList.contains(ngbTemp.id)
                  ? Colors.orange
                  : null),
        ),
        onTap: () => onSelectPhasesByThisCategory(ngbTemp.id));
  }

  copy(String ordem) async {
    Get.snackbar(
      ordem,
      'Ordem copiada.',
      backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
    );
    await Clipboard.setData(ClipboardData(text: ordem));
  }
}
