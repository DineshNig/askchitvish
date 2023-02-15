import 'package:askchitvish/src/View/SubCategoryListWidget.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/controller/Utils.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/service/SidebarService.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RecentlyViewedView extends StatefulWidget {
  // ignore: non_constant_identifier_names

  State<StatefulWidget> createState() => RecentlyViewedState();
}

class RecentlyViewedState extends State {
  var api = SideBarService();
  var con = CategoryController();
  // String recentlyViewed = 'loading';

  List<SubCategoryModel> recentViewedItems = null;

  // Dio dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text('Recently Viewed'),
          backgroundColor: Colors.red,
        ),
        // body:
        // recentlyViewed == 'loading'
        //     ? Center(child: new CircularProgressIndicator())
        //     : recentlyViewed == 'empty'
        //         ? Center(
        //             child: noRecentlyViewed(),
        //           )
        //         : SubCategoryList(
        //             subCategoryList: recentViewedItems,
        //             onTap: (model) => con.navigateToRecipe(context, model),
        //             optional: false),

        body: Helper().isvalidElement(recentViewedItems)
            ? recentViewedItems.length > 0
                ? SubCategoryList(
                    subCategoryList: recentViewedItems,
                    onTap: (model) => con.navigateToRecipe(context, model),
                    optional: false)
                : noRecentlyViewed()
            : Center(child: new CircularProgressIndicator()));
  }

  @override
  void initState() {
    super.initState();
    loadRecentlyViewedItems();
  }

  void loadRecentlyViewedItems() async {
    // api.getRecentViewList();
    // recentViewedItems = [];
    final result = await api.getRecentViewList();
    if (result.length > 0) {
      setState(() {
        recentViewedItems=result;
      });
    }
    setState(() {});
    // setState(() {
    //   if (result.length > 0) {
    //     recentlyViewed = 'found';
    //     recentViewedItems.addAll(result);
    //   } else {
    //     recentlyViewed = 'empty';
    //   }
    // });
  }

  Widget noRecentlyViewed() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text("You have not viewed any Recipes yet !!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
