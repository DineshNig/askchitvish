import 'package:askchitvish/src/View/CategorySearchView.dart';
import 'package:askchitvish/src/View/RecipieImages.dart';
import 'package:askchitvish/src/View/RecipieView.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:askchitvish/src/View/SubCategoryView.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../model/SubCategoryModel.dart';

class CategoryController extends ControllerMVC {
  static CategoryController con;
  void navigateToSubCategory(
      BuildContext context, String str, String name) async {
    Map results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubCategory(category_id: str, name: name),
        ));
  }

  void navigateToRecipe(BuildContext context, SubCategoryModel model) async {
    String str = model.id;
    Map results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Recipe(
            model: model,
            category_id: str,
          ),
        ));
  }

  void navigateToSearch(BuildContext context, String str) async {
    Map results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchView(searchStr: str),
        ));
  }

  void navigateToRecipeImages(
      BuildContext context, SubCategoryModel model) async {
    Map results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeImages(
            model: model,
          ),
        ));
  }
}
