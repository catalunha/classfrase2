import 'package:classfrase/app/data/back4app/enum/phrase_enum.dart';
import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';

abstract class PhraseUseCase {
  Future<String> append(PhraseModel model);
  Future<PhraseModel?> read(String id);

  Future<List<PhraseModel>> list(GetQueryFilterPhrase queryType);
  Future<List<PhraseModel>> listThisPerson(String personId);

  Future<void> delete(String id);
  Future<void> isArchive(String id, bool mode);
  Future<void> onChangeClassOrder(String id, List<String> classOrder);
  Future<void> onSaveClassification(String id,
      Map<String, Classification> classifications, List<String> classOrder);
}
