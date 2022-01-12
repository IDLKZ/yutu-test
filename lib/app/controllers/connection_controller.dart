import 'dart:async';

import 'package:findout/app/widgets/connection_widget.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

import '../routes/app_pages.dart';

class ConnectionController extends GetxController {

  Rx<bool> isConnected = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
   Rx<ConnectivityResult> connectResult = Rx<ConnectivityResult>(ConnectivityResult.none);



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    //connectResult.bindStream(_connectivity.onConnectivityChanged);
    //ever(connectResult,_printconnect);
  }


  _printconnect(ConnectivityResult result){
    print("printconnect");
    print(result);
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
      isConnected.value = true;
      Get.back();

    } else {
      isConnected.value = false;
      Get.offAll(ConnectionWidget());

    }
  }
}
