import 'package:askchitvish/src/globals.dart' as globals;
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';

class DeviceInfoService {
  getDeviceInfo() async {
    print(getDeviceInfo);
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        globals.deviceId = androidInfo.androidId;
        print('Running on ${androidInfo.model}');
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        globals.deviceId = iosDeviceInfo.identifierForVendor;
        print('Running on Device ${globals.deviceId}');
      } else {
        print("No platform");
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
