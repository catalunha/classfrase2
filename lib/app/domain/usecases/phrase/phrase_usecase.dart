import 'package:classfrase/app/data/back4app/enum/phrase_enum.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';

abstract class PhraseUseCase {
  Future<String> append(PhraseModel model);
  Future<List<PhraseModel>> list(GetQueryFilterPhrase queryType);
  Future<void> delete(String id);
  Future<void> isArchive(String id, bool mode);
}
