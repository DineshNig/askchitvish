import 'package:askchitvish/src/View/SubCategoryListWidget.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/service/SidebarService.dart';
import 'package:dio/dio.dart';
import 'package:askchitvish/src/service/SidebarService.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/View/SubCategoryListWidget.dart';
import 'package:flutter/material.dart';

class NewRecipeView extends StatefulWidget {
  // ignore: non_constant_identifier_names

  State<StatefulWidget> createState() => NewRecipeState();
}

class NewRecipeState extends State<NewRecipeView> {
  var api = SideBarService();
  var con = CategoryController();
  String newRecipes = 'loading';

  List<SubCategoryModel> recentlyAdded = new List();
  Dio dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text('New Recipes'),
        backgroundColor: Colors.red,
      ),
      body: newRecipes == 'loading'
          ? Center(child: new CircularProgressIndicator())
          : newRecipes == 'empty'
              ? Center(
                  child: noNewRecipes(),
                )
              : SubCategoryList(
                  subCategoryList: recentlyAdded,
                  onTap: (model) => con.navigateToRecipe(context, model),
                  optional: false),
    );
  }

  @override
  void initState() {
    super.initState();
    LoadRecentlyAddedList();
  }

  void LoadRecentlyAddedList() async {
    final response = await (api.getNewRecipeList());
    setState(() {
      if (response.length > 13) {
        newRecipes = 'found';
        recentlyAdded.addAll(allSubCategoryFromJson(response.toString()));
      } else {
        newRecipes = 'empty';
      }
    });
  }

  Widget noNewRecipes() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text("No New Recipes found !!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
