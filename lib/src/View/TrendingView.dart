import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/service/SidebarService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'SubCategoryListWidget.dart';

class TrendingView extends StatefulWidget {
  // ignore: non_constant_identifier_names
  // FavouriteState createState() => FavouriteState();
  State<StatefulWidget> createState() => TrendingState();
}

class TrendingState extends State<TrendingView> {
  var api = SideBarService();
  var con = CategoryController();
  String trending = 'loading';

  List<SubCategoryModel> trendl = new List();

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
        title: Text('Trending'),
        backgroundColor: Colors.red,
      ),
      body: trending == 'loading'
          ? Center(child: new CircularProgressIndicator())
          : trending == 'empty'
              ? Center(
                  child: noTrending(),
                )
              : SubCategoryList(
                  subCategoryList: trendl,
                  onTap: (model) => con.navigateToRecipe(context, model),
                  optional: false),
    );
  }

  @override
  void initState() {
    super.initState();
    LoadFavList();
  }

  void LoadFavList() async {
    final response = await (api.getTrending());
    setState(() {
      if (response.length > 13) {
        trending = 'found';
        trendl.addAll(allSubCategoryFromJson(response.toString()));
      } else {
        trending = 'empty';
      }
    });
  }

  Widget noTrending() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text("No Trending found !!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
