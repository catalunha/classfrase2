import 'package:classfrase/app/domain/models/classification_model.dart';

abstract class ClassificationRepository {
  Future<ClassificationModel> list();
}
