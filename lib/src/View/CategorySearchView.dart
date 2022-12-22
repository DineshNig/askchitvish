import 'package:askchitvish/src/View/SubCategoryListWidget.dart';
import 'package:dio/dio.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/model/Catelog.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/service/SubCategoryService.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key, this.searchStr}) : super(key: key);
  final String searchStr;
  var con = CategoryController();
  var searchService = new SubCategoryService();
  State<StatefulWidget> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  Map<String, String> nameMap = new Map();
  List<SubCategoryModel> subCategoryModelList = new List();
  List<SubCategoryModel> filteredList;
  var service = SubCategoryService();
  // Future<List<SubCategoryModel>> futureList;
  final Dio dio = new Dio();
  var textController = TextEditingController();
  FocusScopeNode currentFocus;
  bool isSearching;
  bool isLoading;
  bool isNoMatchingResults;
  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);
    return GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
            home: Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(child: cusomizeSearchBar(context)),
              Expanded(child: listViewBuilder())
            ]),
          ),
        )));
  }

  void initState() {
    isSearching = false;
    isLoading = false;
    isNoMatchingResults = false;
    searchCall(widget.searchStr);
    // textController.addListener(() {
    //   if (textController.text.isEmpty) {
    //     if (!currentFocus.hasPrimaryFocus) {
    //       currentFocus.unfocus();
    //     }
    //   }
    // });
  }

  Widget cusomizeSearchBar(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            hintText: widget.searchStr,
            suffixIcon: IconButton(
              onPressed: () {
                if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
                setState(() {
                  isSearching = false;
                  isNoMatchingResults = false;
                });
                textController.clear();
              },
              icon: Icon(Icons.clear),
            ),
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
                filterSearchResult();
              },
            )),
      ),
    );
  }

  void filterSearchResult() {
    filteredList = new List();
    String text = textController.text.toLowerCase();
    if (text.isNotEmpty) {
      if (subCategoryModelList.isNotEmpty) {
        subCategoryModelList.forEach((element) {
          String topicName = element.topic_name.toLowerCase();
          String ingredients = element.ingredients1.toLowerCase();
          if (topicName.contains(text) || ingredients.contains(text)) {
            filteredList.add(element);
          }
        });
        setState(() {
          isSearching = true;
          isLoading = true;
          isNoMatchingResults = filteredList.isEmpty ? true : false;
        });
      } else {
        searchCall(text);
      }
      //  print(filteredList[0]['topic_name']);

    }
  }

  Widget appBar(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
          setState(() {
            isSearching = false;
          });
          textController.clear();
          Navigator.of(context).pop();
        },
      ),
      title: Text('All Category'),
      backgroundColor: Colors.red,
      // bottom: iconRowWidget()
      // bottom: tabBarWidget(context),
    );
  }

  Widget listViewBuilder() {
    if (!isLoading) {
      return buildProgressIndicator();
    } else if (isNoMatchingResults) {
      return Center(child: Text('No Matches Found'));
    } else {
      return isSearching
          ? SubCategoryList(
              subCategoryList: filteredList,
              onTap: (model) {
                if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
                widget.con.navigateToRecipe(context, model);
              },
              optional: true)
          : SubCategoryList(
              subCategoryList: subCategoryModelList,
              onTap: (model) {
                if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
                widget.con.navigateToRecipe(context, model);
              },
              optional: true);
    }
  }

  void searchCall(String search) async {
    final response = await dio.get(service.getSearchURI(search).toString());
    if (response.data['result'].length > 0) {
      setState(() {
        isLoading = true;
        isNoMatchingResults = false;
        subCategoryModelList
            .addAll(allSubCategoryFromJson(response.toString()));
      });
    } else {
      setState(() {
        isNoMatchingResults = true;
        isLoading = true;
      });
    }
  }

  Widget buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }
}
