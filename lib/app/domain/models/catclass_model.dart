class CatClassModel {
  final String id;
  final String name;
  final String? parent;
  final List<String> filter;

  String ordem = '';
  bool isSelected = false;

  CatClassModel({
    required this.id,
    required this.name,
    this.parent,
    required this.filter,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parent': parent,
      'filter': filter,
    };
  }

  factory CatClassModel.fromMap(Map<String, dynamic> map) {
    return CatClassModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      parent: map['parent'],
      filter: List<String>.from(map['filter']),
    );
  }
}
