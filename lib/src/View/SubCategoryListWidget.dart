import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/model/subCategoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void SubCategoryModelCallback(SubCategoryModel val);

class SubCategoryList extends StatelessWidget {
  final List<SubCategoryModel> subCategoryList;
  final Function onTap;
  final bool optional;

  SubCategoryList({this.subCategoryList, this.onTap, this.optional});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double cardHeight = height / 11;
    final double cardFs = cardHeight / 5;
    return ListView.builder(
        itemCount: subCategoryList.length,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (BuildContext context, int pos) {
          return Padding(
              padding: EdgeInsets.all(2),
              child: new InkWell(
                  onTap: () async {
                    var model = subCategoryList[pos];
                    onTap(model);
                  },
                  child: new Card(
                    child: new Container(
                      height: optional ? 95.0 : 70.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Column(
                          children: <Widget>[
                            Column(children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    subCategoryList[pos]
                                        .topic_name
                                        .toString()
                                        .trim(),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        height: 1.5)),
                              ),
                              if (optional) optionalTextWidget(pos),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    SubCategoryModel.categoryNameMap[
                                        subCategoryList[pos].catg_id],
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        height: 1.5)),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  )));
        });
  }

  Widget optionalTextWidget(pos) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(subCategoryList[pos].short_desc.toString().trim(),
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, height: 1.5)),
    );
  }
}
