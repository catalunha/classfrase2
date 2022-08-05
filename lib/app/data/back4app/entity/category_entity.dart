import 'package:classfrase/app/data/back4app/entity/category_group_entity.dart';
import 'package:classfrase/app/domain/models/category_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryEntity {
  static const String className = 'Category';
  ClassCategory fromParse(ParseObject parseObject) {
    // print('CategoryEntity: ${parseObject.objectId}');

    ClassCategory model = ClassCategory(
      id: parseObject.objectId!,
      title: parseObject.get<String>('title') ?? '***',
      description: parseObject.get<String>('description'),
      url: parseObject.get<String>('url'),
      filter: parseObject.get<List<dynamic>>('filter') != null
          ? parseObject
              .get<List<dynamic>>('filter')!
              .map((e) => e.toString())
              .toList()
          : null,
      group: CategoryGroupEntity().fromParse(parseObject.get('group')),
    );
    return model;
  }
}
