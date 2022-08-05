import 'package:classfrase/app/data/back4app/enum/phrase_enum.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';

abstract class PhraseRepository {
  Future<List<PhraseModel>> list(GetQueryFilterPhrase queryType);
  Future<String> append(PhraseModel model);
  Future<void> delete(String id);
  Future<void> isArchive(String id, bool mode);
}
