import 'package:classfrase/app/domain/models/classification_model.dart';

abstract class ClassificationUseCase {
  Future<ClassificationModel> list();
}
