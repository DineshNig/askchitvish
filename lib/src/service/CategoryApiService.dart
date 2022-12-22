import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:askchitvish/src/model/Catelog.dart';
import 'package:askchitvish/src/globals.dart' as globals;
import 'dart:io';

class CatalogService {
  String url = 'http://askchitvish.com/askchitvish/androadmin/catog.php';

  Future<List<Catalog>> getAllCatalog() async {
    final response = await http.get(url);

    return allCatalogFromJson(response.body);
  }

  getCatalogUrl() {
    var queryParam = {
      'uid': getUid(),
    };
    var uri = Uri.http(
        'askchitvish.com', '/askchitvish/androadmin/catog.php', queryParam);
    //print('catalog $uri');
    return uri;
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
}
