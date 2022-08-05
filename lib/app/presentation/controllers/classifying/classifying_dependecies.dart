import 'package:classfrase/app/data/back4app/phrase/phrase_repository_b4a.dart';
import 'package:classfrase/app/data/repositories/phrase_repository.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase_impl.dart';
import 'package:classfrase/app/presentation/controllers/classifying/classifying_controller.dart';
import 'package:get/get.dart';

class ClassifyingDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhraseRepository>(
      () => PhraseRepositoryB4a(),
    );
    Get.lazyPut<PhraseUseCase>(
      () => PhraseUseCaseImpl(
        repository: Get.find(),
      ),
    );

    Get.put<ClassifyingController>(
      ClassifyingController(
        phraseUseCase: Get.find(),
      ),
    );
  }
}
