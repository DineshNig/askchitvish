import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecipeImages extends StatelessWidget {
  RecipeImages({Key key, this.model}) : super(key: key);

  SubCategoryModel model;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: appBar(context),
          body: Container(
              child: imgCarousel(context), alignment: Alignment.center)),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(model.topic_name),
      backgroundColor: Colors.red,
      // bottom: iconRowWidget()
      // bottom: tabBarWidget(context),
    );
  }

  Widget txtBox(BuildContext context) {
    return Container(child: Text(model.images));
  }

  Widget imgBox(BuildContext context) {
    return Container(
        width: double.infinity,
        child: CachedNetworkImage(
          alignment: Alignment.center,
          imageUrl: model.images,
          placeholder: (context, url) =>
              Center(child: new CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(
              child:
                  new Image(image: AssetImage('assets/images/no_image.png'))),
        ));
  }

  Widget imgCarousel(BuildContext context) {
    return Builder(
      builder: (context) {
        final double height = MediaQuery.of(context).size.height;
        return CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 1,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            // autoPlay: false,
          ),
          items: model.images
              .split(",")
              .map((item) => Container(
                    child: Center(
                        child: CachedNetworkImage(
                      alignment: Alignment.center,
                      imageUrl: item,
                      placeholder: (context, url) =>
                          Center(child: new CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(
                          child: new Image(
                              image: AssetImage('assets/images/no_image.png'))),
                    )),
                  ))
              .toList(),
        );
      },
    );
  }
}
