import 'package:classfrase/app/data/back4app/learn/learn_repository_b4a.dart';
import 'package:classfrase/app/data/back4app/phrase/phrase_repository_b4a.dart';
import 'package:classfrase/app/data/back4app/user/user/user_repository_b4a.dart';
import 'package:classfrase/app/data/repositories/learn_repository.dart';
import 'package:classfrase/app/data/repositories/phrase_repository.dart';
import 'package:classfrase/app/data/repositories/user_repository.dart';
import 'package:classfrase/app/domain/usecases/learn/learn_usecase.dart';
import 'package:classfrase/app/domain/usecases/learn/learn_usecase_impl.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase_impl.dart';
import 'package:classfrase/app/domain/usecases/user/user/user_usecase.dart';
import 'package:classfrase/app/domain/usecases/user/user/user_usecase_impl.dart';
import 'package:classfrase/app/presentation/controllers/learn/learn_controller.dart';
import 'package:get/get.dart';

class LearnDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LearnRepository>(
      () => LearnRepositoryB4a(),
    );
    Get.lazyPut<LearnUseCase>(
      () => LearnUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryB4a(),
    );
    Get.lazyPut<UserUseCase>(
      () => UserUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.lazyPut<PhraseRepository>(
      () => PhraseRepositoryB4a(),
    );
    Get.lazyPut<PhraseUseCase>(
      () => PhraseUseCaseImpl(
        repository: Get.find(),
      ),
    );
    Get.put<LearnController>(
      LearnController(
          learnUseCase: Get.find(),
          userUseCase: Get.find(),
          phraseUseCase: Get.find()),
    );
  }
}
