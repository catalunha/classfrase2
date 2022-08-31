import 'package:classfrase/app/domain/models/category_group_model.dart';
import 'package:classfrase/app/domain/models/category_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class PdfController extends GetxController with LoaderMixin, MessageMixin {
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
  void onClose() {
    PhraseController phraseController = Get.find();
    phraseController.updatePhraseInPhraseList(phrase);
    super.onClose();
  }

  @override
  void onInit() async {
    // debug//print'+++ onInit PdfController');
    loaderListener(_loading);
    messageListener(_message);
    _phrase(Get.arguments);
    // debug//printphrase.toString());
    // groupListSorted();
    super.onInit();
  }

  // onSelectPhrase(int phrasePos) {
  //   if (_selectedPosPhraseList.contains(phrasePos)) {
  //     _selectedPosPhraseList.remove(phrasePos);
  //   } else {
  //     _selectedPosPhraseList.add(phrasePos);
  //   }
  // }

  // void groupListSorted() {
  //   /*
  //   ClassificationService classificationService = Get.find();
  //   Map<String, ClassGroup> group = classificationService.classification.group;
  //   List<ClassGroup> groupListTemp = group.entries.map((e) => e.value).toList();
  //   groupListTemp.sort((a, b) => a.title.compareTo(b.title));
  //   groupList.addAll(groupListTemp);
  //   */
  // }
}
