import 'package:classfrase/app/domain/models/phrase_model.dart';

abstract class PhraseRepository {
  Future<List<PhraseModel>> list();
  Future<String> append(PhraseModel model);
  Future<void> delete(String id);
}
