import 'dart:ffi';

import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/service/SidebarService.dart';
import 'package:askchitvish/src/service/SubCategoryService.dart';
import 'package:flutter/material.dart';
import '../model/SubCategoryModel.dart';
import 'package:boxed_text_field/boxed_text_field.dart';
import 'package:askchitvish/src/globals.dart' as globals;

class Recipe extends StatefulWidget {
  Recipe({Key key, this.model, this.category_id}) : super(key: key);
  var con = CategoryController();
  final String category_id;
  SubCategoryModel model;

  @override
  // RecipeState createState() => RecipeState();
  State<StatefulWidget> createState() => RecipeState();
}

class RecipeState extends State<Recipe> {
  var api = SubCategoryService();
  var sideBarserviceapi = SideBarService();
  bool alreadySaved = false;
  double appFontSize = 14.0;

  void initState() {
    String sid = widget.model.id;
    sideBarserviceapi.saveRecentView(sid);
    String favon = widget.model.favon;
    if (favon == 'Y') {
      alreadySaved = true;
    } else {
      alreadySaved = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveFav() {
    String sid = widget.model.id;
    String favon = widget.model.favon;
    if (favon == 'Y') {
      setState(() {
        alreadySaved = false;
      });
      api.deleteFavourite(sid);
    } else {
      setState(() {
        alreadySaved = true;
      });
      api.saveFavourite(sid);
    }
    widget.model.toggleFav();
  }

  void zoomIn() async {
    setState(() {
      appFontSize += 2;
    });
  }

  void zoomOut() async {
    setState(() {
      appFontSize -= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: appBar(context),
          body: ListView(children: [
            iconRowWidget(),
            descRow1(),
            ingredientRow1(),
            methodRow1()
          ])),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(widget.model.topic_name),
      backgroundColor: Colors.red,
    );
  }

  Widget iconRowWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
          color: alreadySaved ? Colors.red : null,
          onPressed: () {
            saveFav();
          },
        ),
        IconButton(
          icon: Icon(Icons.image),
          onPressed: () {
            widget.con.navigateToRecipeImages(context, widget.model);
          },
        ),
        IconButton(
          icon: Icon(Icons.zoom_in),
          onPressed: appFontSize == 18
              ? null
              : () {
                  zoomIn();
                },
        ),
        IconButton(
          icon: Icon(Icons.zoom_out),
          onPressed: appFontSize == 12
              ? null
              : () {
                  zoomOut();
                },
        )
      ],
    );
  }

  Widget descRow1() {
    final width = MediaQuery.of(context).size.width;
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
                widget.model.short_desc == ""
                    ? "love eating"
                    : widget.model.short_desc.trim(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black.withOpacity(1),
                    fontSize: appFontSize,
                    fontStyle: FontStyle.italic)),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              'Servings - ${widget.model.order_no == "" ? "0" : widget.model.order_no.trim()}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black.withOpacity(1), fontSize: appFontSize),
            ),
          ),
        ]));
  }

  Widget ingredientRow1() {
    // double fontsize = appFontSize;
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(children: [
          ListTile(
            tileColor: Colors.grey[350],
            title: Text('Ingredients',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.model.ingredients1 == ""
                      ? "No Ingredients"
                      : widget.model.ingredients1.trim(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: appFontSize),
                ),
              )),
        ]));
  }

  Widget methodRow1() {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(children: [
          ListTile(
              tileColor: Colors.grey[350],
              title: const Text('Method',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0))),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.model.method1 == ""
                      ? "No Method"
                      : widget.model.method1.trim(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: appFontSize),
                ),
              )),
        ]));
  }
}
