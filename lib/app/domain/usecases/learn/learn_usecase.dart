import 'package:classfrase/app/domain/models/learn_model.dart';

abstract class LearnUseCase {
  Future<List<LearnModel>> list();
  Future<String> append(LearnModel model);
  Future<void> delete(String id);
}
