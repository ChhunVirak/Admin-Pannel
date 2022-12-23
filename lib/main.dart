import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:z1web_adminpanel/config/router/router.gr.dart';
import 'package:z1web_adminpanel/setting/color/app_color.dart';
import 'package:z1web_adminpanel/util/function/local_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Z1 Admin Panel',
      theme: _buildTheme(Get.theme.brightness),
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  return brightness == Brightness.light
      ? ThemeData.light().copyWith(
          primaryColor: AppColor.primarySwatch,
          secondaryHeaderColor: AppColor.primaryColor,
          // ignore: deprecated_member_use
          accentColor: AppColor.primarySwatch,
          cardColor: Colors.white,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 30,
              color: AppColor.primarySwatch,
              fontWeight: FontWeight.w800,
            ),
            headline2: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColor.primarySwatch,
            ),
            headline5: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.primarySwatch,
            ),
            bodyText1: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 14,
              color: Colors.black,
            ),
            headline3: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 14,
              color: AppColor.primarySwatch,
            ),
            headline4: TextStyle(
                fontFamily: 'KdamThmorPro',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            headline6: TextStyle(
                fontFamily: 'KdamThmorPro',
                fontSize: 16,
                color: AppColor.primarySwatch,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: AppColor.primarySwatch,
            ),
          ),
        )
      : ThemeData.dark().copyWith(
          primaryColor: AppColor.primarySwatch,
          secondaryHeaderColor: AppColor.primaryColor,
          // ignore: deprecated_member_use
          accentColor: Colors.white,
          cardColor: const Color(0xffDEE8E9).withOpacity(0.1),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
            headline5: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
                fontFamily: 'KdamThmorPro',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyText2: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 16,
              color: Colors.white,
            ),
            headline3: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 16,
              color: Colors.white,
            ),
            headline4: TextStyle(
                fontFamily: 'KdamThmorPro',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            headline6: TextStyle(
                fontFamily: 'KdamThmorPro',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
              fontFamily: 'KdamThmorPro',
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        );
}
