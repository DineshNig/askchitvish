import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:html_unescape/html_unescape.dart';
part 'SubCategoryModel.g.dart';

List<SubCategoryModel> allSubCategoryFromJson(String str) {
  final jsonData = json.decode(str);
  Map<String, dynamic> map = json.decode(str);

  List<dynamic> data = map["result"];

  return new List<SubCategoryModel>.from(
      data.map((x) => subCategoryModelFromJson(x)));
}

@JsonSerializable()
class SubCategoryModel extends Equatable {
  static Map<String, String> categoryNameMap;
  static var unescape = new HtmlUnescape();
  String id;
  String catg_id;
  String topic_name;
  String short_desc;
  String ingredients1;
  String method1;
  String order_no;
  String times_viewed;
  String images;
  String audio;
  String video;
  String active;
  String favon;

  SubCategoryModel(
      {this.id,
      this.catg_id,
      this.topic_name,
      this.short_desc,
      this.ingredients1,
      this.method1,
      this.order_no,
      this.times_viewed,
      this.images,
      this.audio,
      this.video,
      this.active,
      this.favon}) {
    this.short_desc = unescape.convert(this.short_desc);
    this.ingredients1 = unescape.convert(this.ingredients1);
    this.method1 = unescape.convert(this.method1);
    initCategoryNameMap();
  }

  toggleFav() {
    this.favon = this.favon == 'Y' ? 'N' : 'Y';
  }

  initCategoryNameMap() {
    categoryNameMap = {
      '6': 'Cookies and Cakes',
      '1': 'Desserts and Ice creams',
      '12': 'Drinks and Smoothies',
      '16': 'Health and Herbal Food',
      '19': 'Home Remedies',
      '3': 'Kuzhambus and Dhals',
      '15': 'Menus and Jiffy Cooking',
      '13': 'Microwave Cookery',
      '14': 'Miscellaneous',
      '18': 'Layered Cooking',
      '9': 'Pastas and Casseroles',
      '4': 'Rasams and Soups',
      '11': 'Rice and Pulaos',
      '7': 'Rotis and Breads',
      '5': 'Salads and Pickles',
      '25': 'Snacks',
      '10': 'Subjis and Vegetables',
      '2': 'Sweets and Payasams',
      '8': 'Tiffins',
      '26': 'Traditional Cooking'
    };
  }
}
