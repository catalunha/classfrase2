import 'package:classfrase/app/data/repositories/classification_repository.dart';
import 'package:classfrase/app/domain/models/classification_model.dart';
import 'package:classfrase/app/domain/usecases/classification/classification_usecase.dart';

class ClassificationUseCaseImpl implements ClassificationUseCase {
  final ClassificationRepository _repository;
  ClassificationUseCaseImpl({
    required ClassificationRepository repository,
  }) : _repository = repository;

  @override
  Future<ClassificationModel> list() async => await _repository.list();
}
