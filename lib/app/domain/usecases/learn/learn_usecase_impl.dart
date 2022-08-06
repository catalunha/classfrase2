import 'package:classfrase/app/data/repositories/learn_repository.dart';
import 'package:classfrase/app/domain/models/learn_model.dart';
import 'package:classfrase/app/domain/usecases/learn/learn_usecase.dart';

class LearnUseCaseImpl implements LearnUseCase {
  final LearnRepository _repository;
  LearnUseCaseImpl({
    required LearnRepository repository,
  }) : _repository = repository;
  @override
  Future<String> append(LearnModel model) async =>
      await _repository.append(model);

  @override
  Future<void> delete(String id) async => await _repository.delete(id);

  @override
  Future<List<LearnModel>> list() async => await _repository.list();
}
