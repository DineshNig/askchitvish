import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'SubCategoryModel.dart';

class SubCategoryList {
  List<SubCategoryModel> SubCatList;
  Map<String, SubCategoryModel> subCatMap;

  List<SubCategoryModel> getSubCategoryList() {
    return SubCatList;
  }

  void setSubCategoryList(List<SubCategoryModel> SubCatList) {
    this.SubCatList = SubCatList;
  }
}
