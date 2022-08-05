import 'package:classfrase/app/data/back4app/entity/category_entity.dart';
import 'package:classfrase/app/data/back4app/entity/category_group_entity.dart';
import 'package:classfrase/app/data/repositories/classification_repository.dart';
import 'package:classfrase/app/domain/models/category_group_model.dart';
import 'package:classfrase/app/domain/models/category_model.dart';
import 'package:classfrase/app/domain/models/classification_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ClassificationRepositoryB4a extends ClassificationRepository {
  Future<QueryBuilder<ParseObject>> getQueryCategory() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CategoryEntity.className));
    query.includeObject(['group']);
    query.setLimit(400);
    return query;
  }

  Future<QueryBuilder<ParseObject>> getQueryCategoryGroup() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CategoryGroupEntity.className));
    return query;
  }

  @override
  Future<ClassificationModel> list() async {
    var query = await getQueryCategoryGroup();

    final ParseResponse response = await query.query();
    Map<String, ClassGroup> group = <String, ClassGroup>{};
    if (response.success && response.results != null) {
      print('groups: ${response.results!.length}');
      for (var element in response.results!) {
        // print((element as ParseObject).objectId);
        group[element.objectId!] = CategoryGroupEntity().fromParse(element);
      }
    } else {
      print('Sem groups...');
    }

    var queryCat = await getQueryCategory();

    final ParseResponse responseCat = await queryCat.query();
    Map<String, ClassCategory> category = <String, ClassCategory>{};
    if (responseCat.success && responseCat.results != null) {
      print('categorys: ${responseCat.results!.length}');

      for (var element in responseCat.results!) {
        // print((element as ParseObject).objectId);
        category[element.objectId!] = CategoryEntity().fromParse(element);
      }
    } else {
      print('Sem categorys...');
    }
    return ClassificationModel(group: group, category: category);
  }
}
