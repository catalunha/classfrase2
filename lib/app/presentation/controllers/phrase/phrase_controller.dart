import 'package:classfrase/app/data/back4app/enum/phrase_enum.dart';
import 'package:classfrase/app/data/back4app/phrase/phrase_repository_exception.dart';
import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/routes.dart';
import 'package:get/get.dart';

class PhraseController extends GetxController with LoaderMixin, MessageMixin {
  final PhraseUseCase _phraseUseCase;

  PhraseController({required PhraseUseCase phraseUseCase})
      : _phraseUseCase = phraseUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  final _phraseList = <PhraseModel>[].obs;
  List<PhraseModel> get phraseList => _phraseList;

  final _phraseArchivedList = <PhraseModel>[].obs;
  List<PhraseModel> get phraseArchivedList => _phraseArchivedList;

  final _phrase = Rxn<PhraseModel>();
  PhraseModel? get phrase => _phrase.value;

  var isSortedByFolder = true.obs;
  @override
  void onReady() async {
    // TODO: implement onReady
    await listAll();
    super.onReady();
  }

  @override
  void onInit() async {
    // debug//print'+++ onInit PhraseController');
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);
    _phraseList.clear();
    List<PhraseModel> temp =
        await _phraseUseCase.list(GetQueryFilterPhrase.all);
    _phraseList(temp);
    for (var element in phraseList) {
      print('${element.id} - ${element.folder}');
    }
    _loading(false);
  }

  Future<void> listArchived() async {
    _phraseArchivedList.clear();
    List<PhraseModel> temp =
        await _phraseUseCase.list(GetQueryFilterPhrase.archived);
    _phraseArchivedList(temp);
    Get.toNamed(Routes.phraseArchived);
  }

  void unArchivePhrase(String id) async {
    // debug//print'UnarchivePhrase: $id');
    var phraseTemp =
        _phraseArchivedList.firstWhere((element) => element.id == id);
    _phraseArchivedList.clear();
    await _phraseUseCase.isArchive(phraseTemp.id!, false);
    await listAll();
    Get.back();
  }

  void add() {
    _phrase.value = null;
    Get.toNamed(Routes.phraseAddEdit);
  }

  void edit(String id) {
    var phraseTemp = _phraseList.firstWhere((element) => element.id == id);
    _phrase(phraseTemp);
    Get.toNamed(Routes.phraseAddEdit);
  }

  Future<void> addedit({
    required String phrase,
    String folder = '',
    String font = '',
    String diagramUrl = '',
    String note = '',
    bool isArchived = false,
    bool isPublic = false,
    bool isDeleted = false,
  }) async {
    // debug//print'addedit $phrase');
    try {
      _loading(true);
      UserModel userModel;
      String? modelId;
      Map<String, Classification> classifications = <String, Classification>{};
      List<String> classOrder = [];
      if (this.phrase == null) {
        SplashController splashController = Get.find();
        userModel = splashController.userModel!;
      } else {
        classifications.addAll(this.phrase!.classifications);
        classOrder.addAll(this.phrase!.classOrder);
        userModel = this.phrase!.user;
        modelId = this.phrase!.id;
      }
      PhraseModel model = PhraseModel(
          id: modelId,
          user: userModel,
          phrase: phrase,
          folder: folder,
          font: font,
          isArchived: isArchived,
          diagramUrl: diagramUrl,
          note: note,
          isPublic: isPublic,
          isDeleted: isDeleted,
          phraseList: PhraseModel.setPhraseList(phrase),
          classifications: classifications,
          classOrder: classOrder);
      modelId = await _phraseUseCase.append(model);
    } on PhraseRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      listAll();
      _loading(false);
    }
  }

  sortByFolder(bool value) {
    isSortedByFolder(value);
    sortBy();
  }

  sortBy() {
    if (isSortedByFolder.isTrue) {
      _phraseList.sort((a, b) => a.folder.compareTo(b.folder));
    } else {
      _phraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
    }
  }

  void updatePhraseInPhraseList(PhraseModel phraseClassifying) {
    _phraseList.removeWhere((element) => element.id == phraseClassifying.id);
    _phraseList.add(phraseClassifying);
    _phraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
    sortBy();
  }
}
