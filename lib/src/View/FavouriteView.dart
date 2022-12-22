import 'package:askchitvish/src/View/SubCategoryListWidget.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/service/SidebarService.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FavouriteView extends StatefulWidget {
  // ignore: non_constant_identifier_names
  // FavouriteState createState() => FavouriteState();
  State<StatefulWidget> createState() => FavouriteState();
}

class FavouriteState extends State<FavouriteView> {
  var api = SideBarService();
  var con = CategoryController();
  String favourites = 'loading';

  List<SubCategoryModel> favl = new List();

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
        title: Text('My Favourites'),
        backgroundColor: Colors.red,
      ),
      body: favourites == 'loading'
          ? Center(child: new CircularProgressIndicator())
          : favourites == 'empty'
              ? Center(
                  child: noFav(),
                )
              : SubCategoryList(
                  subCategoryList: favl,
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
    final response = await dio.get(api.getFavouriteUri());
    setState(() {
      if (response.data.length > 13) {
        favourites = 'found';
        favl.addAll(allSubCategoryFromJson(response.toString()));
      } else {
        favourites = 'empty';
      }
    });
  }

  Widget noFav() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text("No Favourites found !!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
