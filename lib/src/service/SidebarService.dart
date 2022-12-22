import 'dart:async';
import 'dart:io';

import 'package:askchitvish/src/globals.dart' as globals;
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class SideBarService {
  final Dio dio = new Dio();
  String getUid() {
    String uid;
    if (Platform.isAndroid) {
      uid = globals.deviceId;
    } else if (Platform.isIOS) {
      uid = globals.deviceId;
    }
    return uid;
  }

  getFavouriteUri() {
    var queryParam = {'uid': getUid()};
    var uri;
    if (Platform.isAndroid) {
      uri = Uri.http(
          'askchitvish.com', '/askchitvish/androadmin/favouri.php', queryParam);
    } else if (Platform.isIOS) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/favouri_ios.php', queryParam);
    }

    // print(uri);
    // final response = await dio.get(uri);

    // List<SubCategoryModel> subcategorylist =
    //allSubCategoryFromJson(response.toString());
    return uri.toString();
  }

  Future<List<SubCategoryModel>> getRecentViewList() async {
    var queryParam = {'uid': getUid()};
    var uri;
    if (Platform.isAndroid) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/recentlist.php', queryParam);
    } else if (Platform.isIOS) {
      uri = Uri.http('askchitvish.com',
          'askchitvish/androadmin/recentlist_ios.php', queryParam);
    }
    // print(uri);
    final response = await http.get(uri);

    List<SubCategoryModel> subcategorylist =
        allSubCategoryFromJson(response.body);
    return subcategorylist.toList();
  }

  getNewRecipeList() async {
    var uri;
    if (Platform.isAndroid) {
      uri = 'http://askchitvish.com/askchitvish/androadmin/newrecipe.php';
    } else if (Platform.isIOS) {
      uri = 'http://askchitvish.com/askchitvish/androadmin/newrecipe_ios.php';
    }

    final response = await http.get(uri);

    return response.body;
  }

  getTrending() async {
    var uri;
    if (Platform.isAndroid) {
      uri = 'http://askchitvish.com/askchitvish/androadmin/aac.php';
    } else if (Platform.isIOS) {
      uri = 'http://askchitvish.com/askchitvish/androadmin/aac_ios.php';
    }

    final response = await http.get(uri);

    return response.body;
  }

  void saveRecentView(String sid) async {
    String uid;
    var url;
    if (Platform.isAndroid) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/recme.php';
    } else if (Platform.isIOS) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/recme_ios.php';
    }

    var response = await http.post(url, body: {'uid': uid, 'sid': sid});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
  }
}
