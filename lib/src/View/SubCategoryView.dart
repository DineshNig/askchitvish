import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:askchitvish/src/service/SubCategoryService.dart';
import 'package:askchitvish/src/model/subCategoryList.dart';
import 'dart:async';
import '../model/subCategoryList.dart';
import 'package:askchitvish/src/globals.dart' as globals;

class SubCategory extends StatefulWidget {
  SubCategory({Key key, this.category_id, this.name}) : super(key: key);

  final String category_id;
  final String name;
  @override
  // State<StatefulWidget> createState() => SubCategoryState();
  SubCategoryState createState() => SubCategoryState();
}

class SubCategoryState extends State<SubCategory> {
  var api = SubCategoryService();
  int page = 0;
  bool isLoading = false;
  bool isEnd = false;
  ScrollController sc = ScrollController();
  final Dio dio = new Dio();
  var con = CategoryController();
  //List subCategoryList = new List();
  List<SubCategoryModel> modelList = new List();
  final SearchBarController<SubCategoryModel> searchBarController =
      SearchBarController();
  var searchService = new SubCategoryService();
  String catg_id;

  @override
  void initState() {
    this._getMoreData(page);
    super.initState();
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pop();
                      }),
                  title: Text(widget.name),
                  backgroundColor: Colors.red,
                ),
                body: searchBar(context))));
  }

  Widget buildSubCategoryList(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return ListView.builder(
      itemCount: isEnd ? modelList.length : modelList.length + 1,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int pos) {
        if (pos == modelList.length && isEnd == false) {
          return _buildProgressIndicator();
        } else {
          return Padding(
              padding: EdgeInsets.all(2),
              child: new InkWell(
                  onTap: () async {
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.hasFocus) {
                      FocusManager.instance.primaryFocus.unfocus();
                    }
                    con.navigateToRecipe(context, modelList[pos]);
                  },
                  child: cardWidget(pos)));
        }
      },
      controller: isEnd ? sc : sc,
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _getMoreData(int index) async {
    var uid = globals.deviceId;
    if (mounted && !isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    if (Platform.isIOS) {
      index = index + 1;
    }
    var url = api.getSubCategoryURI(widget.category_id, index.toString());
    List<SubCategoryModel> sList = new List();
    final response = await dio.get(url);
    if (response.data['result'].length > 0) {
      //   List tList = new List();

      //   for (int i = 0; i < response.data['result'].length; i++) {
      //     tList.add(response.data['result'][i]);
      //   }
      sList = allSubCategoryFromJson(response.toString());
      setState(() {
        isLoading = false;
        // subCategoryList.addAll(tList);
        modelList.addAll(sList);
        page++;
      });
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
          isEnd = true;
        });
      }
    }
  }

  Widget searchBar(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    var isSearch = false;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar<SubCategoryModel>(
            searchBarStyle: SearchBarStyle(backgroundColor: Colors.white),
            hintText: 'Search Here...',
            searchBarController: searchBarController,
            // debounceDuration: Duration(microseconds: 20),
            onSearch: (txt) {
              isSearch = true;
              return searchService.searchSubCategory(txt, widget.category_id);
            },
            placeHolder: buildSubCategoryList(context),
            emptyWidget: Center(child: Text("No match found")),
            crossAxisCount: 1,
            onItemFound: (SubCategoryModel model, int index) {
              if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              } else {
                isSearch = false;
              }
              return new Padding(
                  padding: EdgeInsets.all(2),
                  child: new InkWell(
                      onTap: () async {
                        con.navigateToRecipe(context, model);
                      },
                      child: Card(
                        child: new Container(
                          height: 70,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(model.topic_name,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(model.short_desc,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
                                            height: 1.5)),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      )));
            }));
  }

  Widget cardWidget(int index) {
    return Builder(builder: (context) {
      final double height = MediaQuery.of(context).size.height;
      final double cardHeight = height / 11;
      final double cardFs = cardHeight / 5;
      return Card(
          child: new Container(
        height: 70,
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    modelList[index].topic_name.trim(),
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(modelList[index].short_desc.trim(),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          height: 1.5)),
                ),
              ]),
            ),
          ],
        ),
      ));
    });
  }
}
