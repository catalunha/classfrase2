import 'dart:convert';
import 'dart:io';

import 'package:classfrase/app/domain/models/catclass_model.dart';

final List<CatClassModel> categoryAll = <CatClassModel>[];
void main() {
  print('Start');
  var jsonData =
      File('/home/catalunha/myapp/classfrase/assets/data/catclass.json')
          .readAsStringSync();
  final jsonObj = json.decode(jsonData);
  categoryAll.clear();
  for (var element in jsonObj) {
    categoryAll.add(CatClassModel.fromMap(element));
  }
  print(categoryAll.length);
  Ordem ordem = Ordem();
  ordem.categoryAll.addAll([...categoryAll]);
  ordem.existOrphan();
  ordem.updateOrdem();
  print(ordem.categoryAll.length);
  var fileOpen =
      File('/home/catalunha/myapp/classfrase/bin/output/catclass.csv')
          .openWrite(mode: FileMode.append);

  for (var cat in ordem.categoryAll) {
    fileOpen.writeln(
        '${cat.id}|${cat.ordem}|${cat.name}|${cat.parent}|${cat.filter.join("|")}');
  }
  fileOpen.close();
  var fileOpen2 =
      File('/home/catalunha/myapp/classfrase/bin/output/catclass-ordered.json')
          .openWrite(mode: FileMode.append);

  fileOpen2.writeln("[");
  for (var cat in ordem.categoryAll) {
    fileOpen2.writeln('${cat.toJson()},');
  }
  fileOpen2.writeln("]");
  fileOpen2.close();
}

class Ordem {
  final List<CatClassModel> categoryAll = <CatClassModel>[];
  // final List<CatClassModel> category = <CatClassModel>[];
  final List<String> _categoryParentList = <String>[];
  void updateOrdem() {
    for (var i = 0; i < categoryAll.length; i++) {
      categoryAll[i].ordem = getParent(ngb: categoryAll[i]);
    }
    categoryAll.sort((a, b) => a.ordem.compareTo(b.ordem));
  }

  String getParent({required CatClassModel ngb, String delimiter = ' - '}) {
    _categoryParentList.clear();
    List<String> ordemList = _getParents(ngb);
    String ordem = ordemList.reversed.join(delimiter);
    return ordem;
  }

  List<String> _getParents(CatClassModel ngb) {
    _categoryParentList.add(ngb.name);

    CatClassModel ngbParent = categoryAll.firstWhere(
        (element) => element.id == ngb.parent,
        orElse: () => CatClassModel(id: '', name: '', filter: []));

    if (ngbParent.id.isNotEmpty) {
      _getParents(ngbParent);
    }
    return _categoryParentList;
  }

  void existOrphan() {
    for (var element in categoryAll) {
      CatClassModel ngbParent = categoryAll.firstWhere(
          (e) => e.id == element.parent,
          orElse: () => CatClassModel(id: '', name: '', filter: []));
      if (ngbParent.id == '') {
        print('Orfão: ${element.name}');
      }
    }
  }
}
