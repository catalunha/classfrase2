import 'dart:convert';

import 'package:classfrase/app/domain/models/catclass_model.dart';
import 'package:classfrase/app/presentation/views/utils/app_assets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ClassificationService extends GetxService {
  final List<CatClassModel> categoryAll = <CatClassModel>[];
  final List<CatClassModel> category = <CatClassModel>[].obs();
  final List<String> _categoryParentList = <String>[];
  bool selectedNgb = true;

  @override
  void onInit() async {
    // listClassification();
    await readCategory();

    super.onInit();
  }

  Future<void> readCategory() async {
    print('+++++++++++++++ read json +++++++++++++++');
    dynamic data = await _loadJsonCategory();
    categoryAll.clear();
    for (var element in data) {
      categoryAll.add(CatClassModel.fromMap(element));
    }
    updateOrdem();
    categoryFilteredBy('ngb');
    print('-------------- read json --------------');
  }

  Future<dynamic> _loadJsonCategory() async {
    var jsonData = await rootBundle.loadString(AppAssets.catclass);
    final data = json.decode(jsonData);
    return data;
  }

  void updateOrdem() {
    for (var i = 0; i < categoryAll.length; i++) {
      categoryAll[i].ordem = getParent(ngb: categoryAll[i]);
    }
  }

  // void updateIsSelected(List<String> idSelected) {
  //   for (var i = 0; i < category.length; i++) {
  //     if (idSelected.contains(category[i].id)) {
  //       category[i].isSelected = true;
  //     } else {
  //       category[i].isSelected = false;
  //     }
  //   }
  // }

  String getParent({required CatClassModel ngb, String delimiter = ' - '}) {
    _categoryParentList.clear();
    List<String> ordemList = _getParents(ngb);
    String ordem = ordemList.reversed.join(delimiter);
    return ordem;
  }

  List<String> _getParents(CatClassModel ngb) {
    _categoryParentList.add(ngb.name);

    CatClassModel? ngbParent =
        categoryAll.firstWhereOrNull((element) => element.id == ngb.parent);

    if (ngbParent != null) {
      _getParents(ngbParent);
    }
    return _categoryParentList;
  }

  // metodos externos
  void categoryFilteredBy(String filter) {
    if (filter == 'ngb') {
      selectedNgb = true;
    } else {
      selectedNgb = false;
    }
    List<CatClassModel> categoryTemp = categoryAll
        .where((element) => element.filter.contains(filter))
        .toList();
    category.clear();
    category.addAll([...categoryTemp]);
  }
}
