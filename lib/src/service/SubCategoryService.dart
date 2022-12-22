import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:askchitvish/src/model/SubCategoryModel.dart';
import 'package:askchitvish/src/model/subCategoryList.dart';
import 'package:askchitvish/src/globals.dart' as globals;

import '../View/SubCategoryView.dart';

class SubCategoryService {
  void saveFavourite(String sid) async {
    String uid;
    var url;
    if (Platform.isAndroid) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/favin.php';
    } else if (Platform.isIOS) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/favin_ios.php';
    }

    var response = await http.post(url, body: {'uid': uid, 'sid': sid});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
  }

  void deleteFavourite(String sid) async {
    String uid;
    var url;
    if (Platform.isAndroid) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/favdel.php';
    } else if (Platform.isIOS) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/favdel_ios.php';
    }

    var response = await http.post(url, body: {'uid': uid, 'sid': sid});
    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
  }

  Future<List<SubCategoryModel>> searchSubCategory(
      String search, String catg_id) async {
    var uri;
    var queryParam = {
      'uid': getUid(),
      'catg_id': catg_id,
      'pompom': search,
    };
    if (Platform.isAndroid) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/subcatsercfi.php', queryParam);
    } else if (Platform.isIOS) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/subcatsercfi_ios.php', queryParam);
    }

    final response = await http.get(uri);

    List<SubCategoryModel> subcategorylist =
        allSubCategoryFromJson(response.body);

    return subcategorylist.toList();
  }

  String getUid() {
    String uid;
    if (Platform.isAndroid) {
      uid = globals.deviceId;
    } else if (Platform.isIOS) {
      uid = globals.deviceId;
    }
    return uid;
  }

  getSearchURI(String search) {
    var uri;

    var queryParam = {'uid': getUid(), 'pompom': search, 'page': "1"};
    if (Platform.isAndroid) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/mainsercfi.php', queryParam);
    } else if (Platform.isIOS) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/mainsercfi_ios.php', queryParam);
    }
    //print('URI---:$uri');
    return uri;
  }

  getSubCategoryURI(String catg_id, String page) {
    var uri;

    var queryParam = {'uid': getUid(), 'catg_id': catg_id, 'page': page};
    if (Platform.isAndroid) {
      uri = Uri.http('askchitvish.com', '/askchitvish/androadmin/sub_catog.php',
          queryParam);
    } else if (Platform.isIOS) {
      uri = Uri.http('askchitvish.com',
          '/askchitvish/androadmin/sub_catog_ios.php', queryParam);
    }

    //print('URI===:$uri');
    return uri.toString();
  }

  /* Future<List<SubCategoryModel>> getFavouriteList() async {
    var queryParam = {
      'uid': getUid()
      
    };
    var uri;
     if (Platform.isAndroid) {
      uri = Uri.http(
        'askchitvish.com', '/askchitvish/androadmin/favouri.php', queryParam);
    } else if (Platform.isIOS) {
     uri = Uri.http(
        'askchitvish.com', '/askchitvish/androadmin/favouri_ios.php', queryParam);
    }
     
    print(uri);
    final response = await http.get(uri);

    List<SubCategoryModel> subcategorylist =
        allSubCategoryFromJson(response.body);
    return subcategorylist.toList();
  }

   Future<List<SubCategoryModel>> getRecentViewList() async {
     var url;
    var queryParam = {
      'uid': getUid()
      
    };
    var uri;
      if (Platform.isAndroid) {
      url = 'http://askchitvish.com/askchitvish/androadmin/recentlist.php';
    } else if (Platform.isIOS) {
     url = 'http://askchitvish.com/askchitvish/androadmin/recentlist_ios.php';
    }
    print(uri);
    final response = await http.get(uri);

    List<SubCategoryModel> subcategorylist =
        allSubCategoryFromJson(response.body);
    return subcategorylist.toList();
  }

  void saveRecentView(String sid) async {
    String uid;
    var url;
    if (Platform.isAndroid) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/recentlist.php';
    } else if (Platform.isIOS) {
      uid = globals.deviceId;
      url = 'http://askchitvish.com/askchitvish/androadmin/recentlist_ios.php';
    }

    var response = await http.post(url, body: {'uid': uid, 'sid': sid});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }*/
}
