import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:get/get.dart';

class ClassificationDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<ClassificationService>(
      ClassificationService(),
    );
  }
}
