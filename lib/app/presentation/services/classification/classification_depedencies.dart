import 'package:classfrase/app/data/back4app/classification/classification_repository_b4a.dart';
import 'package:classfrase/app/data/repositories/classification_repository.dart';
import 'package:classfrase/app/domain/usecases/classification/classification_usecase.dart';
import 'package:classfrase/app/domain/usecases/classification/classification_usecase_impl.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:get/get.dart';

class ClassificationDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassificationRepository>(
      () => ClassificationRepositoryB4a(),
    );
    Get.lazyPut<ClassificationUseCase>(
      () => ClassificationUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<ClassificationService>(
      ClassificationService(
        classificationUseCase: Get.find(),
      ),
    );
  }
}
