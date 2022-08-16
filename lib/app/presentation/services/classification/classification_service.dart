import 'dart:convert';

import 'package:classfrase/app/domain/models/catclass_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ClassificationService extends GetxService {
  final List<CatClassModel> _category = <CatClassModel>[];
  final List<CatClassModel> category = <CatClassModel>[].obs();
  final List<String> _categoryParentList = <String>[];

  @override
  void onInit() async {
    // listClassification();
    await readCategory();

    super.onInit();
  }

  Future<void> readCategory() async {
    dynamic data = await _loadJsonCategory();
    _category.clear();
    for (var element in data) {
      _category.add(CatClassModel.fromMap(element));
    }
    updateOrdem();
    filterCategory('ngb');
  }

  Future<dynamic> _loadJsonCategory() async {
    var jsonData = await rootBundle.loadString('assets/catclass/catclass.json');
    final data = json.decode(jsonData);
    return data;
  }

  void updateOrdem() {
    for (var i = 0; i < _category.length; i++) {
      _category[i].ordem = getParent(ngb: _category[i]);
    }
  }

  String getParent({required CatClassModel ngb, String delimiter = ' - '}) {
    _categoryParentList.clear();
    List<String> ordemList = _getParents(ngb);
    String ordem = ordemList.reversed.join(delimiter);
    return ordem;
  }

  List<String> _getParents(CatClassModel ngb) {
    _categoryParentList.add(ngb.name);

    CatClassModel? ngbParent =
        category.firstWhereOrNull((element) => element.id == ngb.parent);

    if (ngbParent != null) {
      _getParents(ngbParent);
    }
    return _categoryParentList;
  }

  // metodos externos
  void filterCategory(String filter) {
    List<CatClassModel> categoryTemp =
        _category.where((element) => element.filter.contains(filter)).toList();
    category.clear();
    category.addAll([...categoryTemp]);
  }
}
