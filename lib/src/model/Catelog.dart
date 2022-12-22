import 'dart:convert';

Catalog catalogFromJson(String str) {
  final jsonData = json.decode(str);
  return Catalog.fromJson(jsonData);
}

String catalogToJson(Catalog data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Catalog> allCatalogFromJson(String str) {
  final jsonData = json.decode(str);
  Map<String, dynamic> map = json.decode(str);
  List<dynamic> data = map["result"];

  return new List<Catalog>.from(data.map((x) => Catalog.fromJson(x)));
}

String allCatalogToJson(List<Catalog> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Catalog {
  String id;
  String name;
  String description;
  String image;
  String display_name;
  String active;

  Catalog({
    this.id,
    this.name,
    this.description,
    this.image,
    this.display_name,
    this.active,
  });

  factory Catalog.fromJson(Map<dynamic, dynamic> json) => new Catalog(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        display_name: json['display_name'],
        active: json['active'],
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'display_name': display_name,
        'active': active
      };

  @override
  String toString() {
    return 'Catelog(id: $id, name: $name, description: $description, image: $image,display_name:$display_name,active:$active)';
  }
}
