import 'package:findout/app/controllers/bindings/initial_binding.dart';
import 'package:findout/app/helpers/global_mixin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'generated/locales.g.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ) ;
 String locale =  await GlobalMixin.getCurrentLocale();
  runApp(myApp(locale: locale,));
}

class myApp extends StatelessWidget {
  late String locale;
  myApp({required this.locale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),
      locale: Locale(locale), // translations will be displayed in that locale
      fallbackLocale: Locale(locale),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
