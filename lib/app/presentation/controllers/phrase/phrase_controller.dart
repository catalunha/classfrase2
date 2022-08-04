import 'package:classfrase/app/data/back4app/phrase/phrase_repository_exception.dart';
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

  final _phrase = Rxn<PhraseModel>();
  PhraseModel? get phrase => _phrase.value;

  @override
  void onInit() async {
    print('+++ init phrase');
    loaderListener(_loading);
    messageListener(_message);
    await list();
    super.onInit();
    print('--- init phrase');
  }

  Future<void> list() async {
    _phraseList.clear();
    List<PhraseModel> temp = await _phraseUseCase.list();
    _phraseList(temp);
  }

  void add() {
    print('phrase add');
    _phrase.value = null;
    Get.toNamed(Routes.phraseAddEdit);
  }

  void edit(String id) {
    print('phrase edit: $id');
    var phraseTemp = _phraseList.firstWhere((element) => element.id == id);
    _phrase(phraseTemp);
    Get.toNamed(Routes.phraseAddEdit);
  }

  Future<void> addedit({
    required String phrase,
    String folder = '',
    String font = '',
    String diagramUrl = '',
    bool isArchived = false,
    bool isPublic = false,
    bool isDeleted = false,
  }) async {
    print('addedit $phrase');
    try {
      _loading(true);
      UserModel userModel;
      String? modelId;
      if (this.phrase == null) {
        SplashController splashController = Get.find();
        userModel = splashController.userModel!;
      } else {
        userModel = this.phrase!.user;
        modelId = this.phrase!.id;
      }
      Map<String, Classification> temp = <String, Classification>{};
      temp['123'] = Classification(categoryIdList: ['456'], posPhraseList: [1]);
      temp['123a'] =
          Classification(categoryIdList: ['456a'], posPhraseList: [2]);
      print(temp);
      PhraseModel model = PhraseModel(
          id: modelId,
          user: userModel,
          phrase: phrase,
          folder: folder,
          isArchived: isArchived,
          isPublic: isPublic,
          isDeleted: isDeleted,
          phraseList: PhraseModel.setPhraseList(phrase),
          classifications: temp,
          classOrder: []);
      modelId = await _phraseUseCase.append(model);
    } on PhraseRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar os dados',
        isError: true,
      );
    } finally {
      list();
      _loading(false);
    }
  }
}
