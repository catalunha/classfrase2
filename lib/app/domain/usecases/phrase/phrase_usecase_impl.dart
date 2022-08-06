import 'package:classfrase/app/data/back4app/enum/phrase_enum.dart';
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
  Future<List<PhraseModel>> list(GetQueryFilterPhrase queryType) async =>
      await _repository.list(queryType);

  @override
  Future<void> isArchive(String id, bool mode) async =>
      await _repository.isArchive(id, mode);

  @override
  Future<void> onChangeClassOrder(String id, List<String> classOrder) async =>
      await _repository.onChangeClassOrder(id, classOrder);

  @override
  Future<void> onSaveClassification(
          String id,
          Map<String, Classification> classifications,
          List<String> classOrder) async =>
      await _repository.onSaveClassification(
        id,
        classifications,
        classOrder,
      );

  @override
  Future<PhraseModel?> read(String id) async => await _repository.read(id);

  @override
  Future<List<PhraseModel>> listThisPerson(String personId) async =>
      await _repository.listThisPerson(personId);
}
