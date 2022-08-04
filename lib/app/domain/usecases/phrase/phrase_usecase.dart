import 'package:classfrase/app/domain/models/phrase_model.dart';

abstract class PhraseUseCase {
  Future<String> append(PhraseModel model);
  Future<List<PhraseModel>> list();
  Future<void> delete(String id);
}
