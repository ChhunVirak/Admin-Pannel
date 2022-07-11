// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../core/auth/screen/loginscreen.dart' as _i1;
import '../module/home/screen/homescreen.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    LoginScreen.name: (routeData) {
      final args = routeData.argsAs<LoginScreenArgs>(
          orElse: () => const LoginScreenArgs());
      return _i3.CustomPage<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(key: args.key, message: args.message),
          opaque: true,
          barrierDismissible: false);
    },
    HomeScreen.name: (routeData) {
      return _i3.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.HomeScreen(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/login', fullMatch: true),
        _i3.RouteConfig(LoginScreen.name, path: '/login'),
        _i3.RouteConfig(HomeScreen.name, path: '/home-screen')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreen extends _i3.PageRouteInfo<LoginScreenArgs> {
  LoginScreen({_i4.Key? key, String? message})
      : super(LoginScreen.name,
            path: '/login', args: LoginScreenArgs(key: key, message: message));

  static const String name = 'LoginScreen';
}

class LoginScreenArgs {
  const LoginScreenArgs({this.key, this.message});

  final _i4.Key? key;

  final String? message;

  @override
  String toString() {
    return 'LoginScreenArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreen extends _i3.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/home-screen');

  static const String name = 'HomeScreen';
}
