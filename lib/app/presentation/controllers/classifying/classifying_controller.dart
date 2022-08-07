import 'package:classfrase/app/domain/models/category_group_model.dart';
import 'package:classfrase/app/domain/models/category_model.dart';
import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:classfrase/app/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ClassifyingController extends GetxController
    with LoaderMixin, MessageMixin {
  final PhraseUseCase _phraseUseCase;

  ClassifyingController({
    required PhraseUseCase phraseUseCase,
  }) : _phraseUseCase = phraseUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _phrase = Rxn<PhraseModel>();
  PhraseModel get phrase => _phrase.value!;

  final _selectedPosPhraseList = <int>[].obs;
  List<int> get selectedPosPhraseList => _selectedPosPhraseList;
  final _selectedCategoryIdList = <String>[].obs;
  List<String> get selectedCategoryIdList => _selectedCategoryIdList;
  final groupList = <ClassGroup>[];
  // List<ClassGroup> get groupList => _groupList;

  //+++ CategoryGroup
  final categoryList = <ClassCategory>[];
  final _groupSelected = Rxn<ClassGroup>();
  ClassGroup get groupSelected => _groupSelected.value!;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('onReady ClassifyingController');
    _phraseUseCase.read(phrase.id!);
  }

  @override
  void onInit() async {
    print('+++ onInit ClassifyingController');
    loaderListener(_loading);
    messageListener(_message);
    _phrase(Get.arguments);
    print(phrase.toString());
    groupListSorted();
    super.onInit();
  }

  onSelectPhrase(int phrasePos) {
    if (_selectedPosPhraseList.contains(phrasePos)) {
      _selectedPosPhraseList.remove(phrasePos);
    } else {
      _selectedPosPhraseList.add(phrasePos);
    }
  }

  void groupListSorted() {
    ClassificationService classificationService = Get.find();
    Map<String, ClassGroup> group = classificationService.classification.group;
    List<ClassGroup> groupListTemp = group.entries.map((e) => e.value).toList();
    groupListTemp.sort((a, b) => a.title.compareTo(b.title));
    groupList.addAll(groupListTemp);
  }

  void categoryFilter() {
    categoryList.clear();
    ClassificationService classificationService = Get.find();
    Map<String, ClassCategory> category =
        classificationService.classification.category;
    print('categoryFilter 1: ${category.length}');
    List<ClassCategory> categoryListTemp =
        category.entries.map((e) => e.value).toList();
    print('categoryFilter 2: ${categoryListTemp.length}');
    List<ClassCategory> categoryFiltered = categoryListTemp
        .where((element) => element.group.id == groupSelected.id)
        .toList();
    categoryFiltered.sort((a, b) => a.title.compareTo(b.title));
    print('categoryFilter 2: ${categoryFiltered.length}');

    categoryList.addAll(categoryFiltered);
  }

  void onChangeClassOrder(List<String> classOrder) async {
    await _phraseUseCase.onChangeClassOrder(phrase.id!, classOrder);
  }

  void onUpdateExistCategoryInPos(String groupId) {
    ClassificationService classificationService = Get.find();
    Map<String, Classification> classifications = phrase.classifications;
    List<int> posPhraseListNow = [..._selectedPosPhraseList];
    posPhraseListNow.sort();
    List<String> categoryIdListNow = [];
    for (var classificationsItem in classifications.entries) {
      if (listEquals(
          classificationsItem.value.posPhraseList, posPhraseListNow)) {
        for (var categoryId in classificationsItem.value.categoryIdList) {
          categoryIdListNow.add(categoryId);
        }
        break;
      }
    }
    _selectedCategoryIdList(categoryIdListNow);
  }

  void onSelectAllPhrase() {
    List<int> allPos = [];
    _selectedPosPhraseList.clear();
    for (var wordPos = 0; wordPos < phrase.phrase.length; wordPos++) {
      if (phrase.phrase[wordPos] != ' ') {
        _selectedPosPhraseList.add(wordPos);
      }
    }
  }

  void onSelectNonePhrase() {
    _selectedPosPhraseList.clear();
  }

  void onSelectInversePhrase() {
    for (var wordPos = 0; wordPos < phrase.phrase.length; wordPos++) {
      if (phrase.phrase[wordPos] != ' ') {
        onSelectPhrase(wordPos);
      }
    }
  }

  //+++ CategoryGroup
  void onGroupSelected(String id) {
    var groupTemp = groupList.firstWhere((element) => element.id == id);
    _groupSelected(groupTemp);
    categoryFilter();
    Get.toNamed(Routes.phraseCategoryGroup);
  }

  void onSelectCategory(String categoryId) {
    if (_selectedCategoryIdList.contains(categoryId)) {
      _selectedCategoryIdList.remove(categoryId);
    } else {
      _selectedCategoryIdList.add(categoryId);
    }
    print(_selectedCategoryIdList);
  }

  void onSaveClassification() async {
    ClassificationService classificationService = Get.find();
    Map<String, Classification> classifications = phrase.classifications;

    List<int> posPhraseListNow = [..._selectedPosPhraseList];
    posPhraseListNow.sort();
    List<String> categoryIdListNow = [..._selectedCategoryIdList];
    String classificationsId = const Uuid().v4();
    for (var classificationsItem in classifications.entries) {
      if (listEquals(
          classificationsItem.value.posPhraseList, posPhraseListNow)) {
        classificationsId = classificationsItem.key;
      }
    }
    Classification classificationNew = Classification(
        posPhraseList: posPhraseListNow, categoryIdList: categoryIdListNow);
    List<String> classOrderTemp = [...phrase.classOrder];
    Map<String, Classification> classificationsTemp =
        <String, Classification>{};
    classificationsTemp.addAll(phrase.classifications);

    if (classificationNew.categoryIdList.isEmpty) {
      classOrderTemp.remove(classificationsId);
      classificationsTemp.remove(classificationsId);
    } else {
      classOrderTemp.addIf(
          !classOrderTemp.contains(classificationsId), classificationsId);
      classificationsTemp[classificationsId] = classificationNew;
    }
    await _phraseUseCase.onSaveClassification(
        phrase.id!, classificationsTemp, classOrderTemp);
    PhraseModel? temp = await _phraseUseCase.read(phrase.id!);
    _phrase(temp);
  }
}
