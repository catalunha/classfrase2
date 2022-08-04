import 'package:classfrase/app/data/repositories/phrase_repository.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:classfrase/app/domain/usecases/phrase/phrase_usecase.dart';

class PhraseUseCaseImpl implements PhraseUseCase {
  final PhraseRepository _repository;
  PhraseUseCaseImpl({
    required PhraseRepository repository,
  }) : _repository = repository;
  @override
  Future<String> append(PhraseModel model) async =>
      await _repository.append(model);

  @override
  Future<void> delete(String id) async => await _repository.delete(id);

  @override
  Future<List<PhraseModel>> list() async => await _repository.list();
}
