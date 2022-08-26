import 'package:classfrase/app/domain/models/category_group_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryGroupEntity {
  static const String className = 'CategoryGroup';
  ClassGroup fromParse(ParseObject parseObject) {
    // //print'CategoryGroupEntity: ${parseObject.objectId}');

    ClassGroup model = ClassGroup(
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
    );
    return model;
  }
}
