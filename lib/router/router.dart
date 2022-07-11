import 'package:auto_route/auto_route.dart';
import 'package:z1web_adminpanel/core/auth/screen/loginscreen.dart';

import '../module/home/screen/homescreen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(page: LoginScreen, path: '/login', initial: true),
    CustomRoute(page: HomeScreen)
  ],
)
class $AppRouter {}
