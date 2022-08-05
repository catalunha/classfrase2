import 'package:classfrase/app/domain/models/classification_model.dart';
import 'package:classfrase/app/domain/usecases/classification/classification_usecase.dart';
import 'package:get/get.dart';

class ClassificationService extends GetxService {
  final ClassificationUseCase _classificationUseCase;

  ClassificationService({required ClassificationUseCase classificationUseCase})
      : _classificationUseCase = classificationUseCase;

  final _classification = Rxn<ClassificationModel>();
  ClassificationModel get classification => _classification.value!;

  @override
  void onInit() async {
    listClassification();
    super.onInit();
  }

  void listClassification() async {
    // final ClassificationUseCase classificationUseCase = Get.find();

    var temp = await _classificationUseCase.list();
    _classification(temp);
    print('Service iniciado...');
    // print(classification.toString());
  }
}
