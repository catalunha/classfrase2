import 'package:classfrase/app/domain/models/catclass_model.dart';
import 'package:classfrase/app/domain/models/category_model.dart';
import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ClassifyingController extends GetxController
    with LoaderMixin, MessageMixin {
  final PhraseUseCase _phraseUseCase;
  final ClassificationService _classificationService;
  ClassifyingController(
      {required PhraseUseCase phraseUseCase,
      required ClassificationService classificationService})
      : _phraseUseCase = phraseUseCase,
        _classificationService = classificationService;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _phrase = Rxn<PhraseModel>();
  PhraseModel get phrase => _phrase.value!;

  final _selectedPosPhraseList = <int>[].obs;
  List<int> get selectedPosPhraseList => _selectedPosPhraseList;
  final _selectedCategoryIdList = <String>[].obs;
  List<String> get selectedCategoryIdList => _selectedCategoryIdList;

  //+++ CategoryGroup
  final categoryList = <ClassCategory>[];

  @override
  void onClose() {
    PhraseController phraseController = Get.find();
    phraseController.updatePhraseInPhraseList(phrase);
    super.onClose();
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    _phrase(Get.arguments);
    super.onInit();
  }

  onSelectPhrase(int phrasePos) {
    if (_selectedPosPhraseList.contains(phrasePos)) {
      _selectedPosPhraseList.remove(phrasePos);
    } else {
      _selectedPosPhraseList.add(phrasePos);
    }
  }

  void onChangeClassOrder(List<String> classOrder) async {
    await _phraseUseCase.onChangeClassOrder(phrase.id!, classOrder);
  }

  Future<void> onMarkCategoryIfAlreadyClassifiedInPos() async {
    _loading(true);
    Map<String, Classification> classifications = phrase.classifications;
    List<int> posPhraseListNow = [..._selectedPosPhraseList];
    posPhraseListNow.sort();
    List<String> categoryIdListNow = [];
    for (var classification in classifications.values) {
      if (listEquals(classification.posPhraseList, posPhraseListNow)) {
        categoryIdListNow.addAll(classification.categoryIdList);
        // for (var categoryId in classification.categoryIdList) {
        //   categoryIdListNow.add(categoryId);
        // }
        break;
      }
    }
    _selectedCategoryIdList(categoryIdListNow);
    _loading(false);
  }

  void onSelectAllPhrase() {
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

  void onSelectCategory(String categoryId) {
    if (_selectedCategoryIdList.contains(categoryId)) {
      _selectedCategoryIdList.remove(categoryId);
    } else {
      _selectedCategoryIdList.add(categoryId);
    }
  }

  Future<void> onSaveClassification() async {
    try {
      _loading(true);
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
    } catch (e) {
      _message.value = MessageModel(
        title: 'Oops',
        message: 'Ocorreu algum erro ao salvar esta classificação',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

// modo catClass
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
        onTap: () => onSelectCategory(ngbTemp.id));
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
