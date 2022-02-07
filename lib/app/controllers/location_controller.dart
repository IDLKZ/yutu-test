import 'package:findout/app/helpers/global_mixin.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LocationController extends GetxController {

  Rx<String> locale = Rx<String>("ru");

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    locale.value = await GlobalMixin.getCurrentLocale();
  }











}
