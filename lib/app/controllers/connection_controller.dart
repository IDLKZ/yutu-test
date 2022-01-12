import 'dart:async';

import 'package:findout/app/widgets/connection_widget.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class ConnectionController extends GetxController {

  Rx<bool> isConnected = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose(){
    _connectivitySubscription.cancel();
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
      //Get.offAllNamed(AppPages.INITIAL);

    } else {
      isConnected.value = false;
      Get.offAll(ConnectionWidget());

    }
  }
}
