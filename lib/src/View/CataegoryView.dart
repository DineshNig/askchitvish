import 'package:askchitvish/src/View/FavouriteView.dart';
import 'package:askchitvish/src/View/NewRecipeView.dart';
import 'package:askchitvish/src/View/RecentlyViewedView.dart';
import 'package:askchitvish/src/View/TrendingView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:askchitvish/src/service/SubCategoryService.dart';
import 'package:flutter/material.dart';
import 'package:askchitvish/src/service/CategoryApiService.dart';
import 'package:askchitvish/src/model/Catelog.dart';
import 'package:askchitvish/src/controller/CategoryController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:askchitvish/src/view/AboutUs.dart';

class CategoryView extends StatefulWidget {
  var api = new CatalogService();
  var con = CategoryController();
  var searchService = new SubCategoryService();
  TextEditingController _textController = TextEditingController();

  Widget drawerWidget(context, currentFocus) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/images/side_home.png',
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.trending_up),
            title: Text('Trending'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TrendingView()));
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.favorite_border),
            title: Text('My Favourites'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouriteView()));
            },
          ),
          ListTile(
            dense: true,
            leading: Transform(
              transform: Matrix4.translationValues(-12, 0.0, 0.0),
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.cookieBite),
                onPressed: () {},
              ),
            ),
            title: Transform(
              transform: Matrix4.translationValues(-10, 0.0, 0.0),
              child: Text('New Recipes'),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewRecipeView()));
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.remove_red_eye),
            title: Text('Recently Viewed'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecentlyViewedView()));
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              dense: true,
              title: Text(
                'Communicate',
                style: TextStyle(color: Colors.black54),
              )),
          ListTile(
            dense: true,
            leading: Transform(
              transform: Matrix4.translationValues(-13, 0.0, 0.0),
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook),
                onPressed: () {},
              ),
            ),
            title: Transform(
              transform: Matrix4.translationValues(-10, 0.0, 0.0),
              child: Text('Facebook'),
            ),
            onTap: () {
              Future<void> _launchFacebook(String url) async {
                if (await canLaunch(url)) {
                  //  print('url---:$url');
                  final bool nativeAppLaunchSucceeded =
                      await launch(url, forceSafariVC: false);
                  if (!nativeAppLaunchSucceeded) {
                    await launch(
                      url,
                      forceSafariVC: true,
                    );
                  }
                } else {
                  try {
                    var fallbackUrl = 'https://www.facebook.com/askchitvish/';
                    bool launched = await launch(url, forceSafariVC: false);

                    if (!launched) {
                      await launch(fallbackUrl, forceSafariVC: false);
                    }
                  } catch (e) {
                    await launch(url, forceSafariVC: false);
                  }
                }
              }

              var link;
              if (Platform.isAndroid) {
                link = 'fb://page/179639008763491';
              }
              if (Platform.isIOS) {
                link = 'fb://profile/179639008763491';
              }
              _launchFacebook(link);
              // Update the state of the app
              // ...
              // Then close the drawer
              print('Launch facebook');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.email_outlined),
            title: Text('Contact Us'),
            onTap: () {
              launch(Uri(
                scheme: 'mailto',
                path: 'appchitvish@gmail.com',
              ).toString());
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              var shareLink;
              if (Platform.isAndroid) {
                shareLink =
                    'https://play.google.com/store/apps/details?id=com.askchitvish.activity.prem&hl=en';
              } else if (Platform.isIOS) {
                shareLink =
                    'https://apps.apple.com/in/app/askchitvish-premium/id473488584';
              }
              final RenderBox box = context.findRenderObject();
              Share.share(
                  'I am happy with this app.Please click the link to download \n' +
                      shareLink,
                  subject: 'Checkout this awesome app for numerous recipes',
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.person),
            title: Text('About Us'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => CategoryState();
}

class CategoryState extends State<CategoryView> {
  String searchStr;

  var dio = Dio();
  List<Catalog> catalogList = new List();

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Categories'),
            backgroundColor: Colors.red,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(child: cusomizeSearchBar(context)),
              Expanded(child: gridViewBuilder(context))
            ]),
          ),
          drawer: widget.drawerWidget(context, currentFocus),
        ));
  }

  void initState() {
    searchStr = "";
    getCategoryList();

    // widget._textController.addListener(() {
    //   if (widget._textController.text.isEmpty) {
    //     if (!currentFocus.hasPrimaryFocus) {
    //       currentFocus.unfocus();
    //     }
    //   }
    // });
  }

  Widget cusomizeSearchBar(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: widget._textController,
        decoration: InputDecoration(
          hintText: 'Search Here...',
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
              widget.con.navigateToSearch(context, widget._textController.text);
            },
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
              widget._textController.clear();
            },
            icon: Icon(Icons.clear),
          ),
        ),
      ),
    );
  }

  Widget gridViewBuilder(context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    var orientation = MediaQuery.of(context).orientation.toString();
    return GridView.builder(
        itemCount: catalogList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(3),
            child: new InkWell(
              onTap: () {
                if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
                widget.con.navigateToSubCategory(
                    context, catalogList[index].id, catalogList[index].name);
              },
              child: new Card(
                child: new Column(children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 0.70,
                    child: CachedNetworkImage(
                      //height: 125,
                      //width: 175,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      imageUrl: catalogList[index].image,
                      placeholder: (context, url) =>
                          Center(child: new CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(
                          child: new Image(
                              image: AssetImage('assets/images/no_image.png'))),
                    ),
                  ),
                  AspectRatio(
                      aspectRatio: 1 / 0.3,
                      child: SizedBox(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(catalogList[index].display_name.trim(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: orientation == 'Orientation.landscape'
                                  ? 25.0
                                  : 14.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ))),
                ]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.all(2.5),
              ),
            ),
          );
        });
  }

  getCategoryList() async {
    String url = 'http://askchitvish.com/askchitvish/androadmin/catog.php';
    final response = await dio.get(url);
    List<Catalog> tList = allCatalogFromJson(response.toString());

    setState(() {
      catalogList.addAll(tList);
    });
  }
}
