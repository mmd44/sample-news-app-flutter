import 'package:flutter/material.dart';
import 'package:topnews/controllers/main_controller.dart';
import 'package:topnews/screens/splash_screen.dart';
import 'package:topnews/utils/app_page_route.dart';

import 'screens/home_screen.dart';
import 'network/network_setup.dart';

var routes = <String, WidgetBuilder>{
};

void main() {
  NetworkSetup().setNetworkHeaders();

  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.deepPurple, accentColor: Colors.deepPurple),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes,
    onGenerateRoute: (settings) {
      if (settings.name == "/home") {
        final MainController controller = settings.arguments;
        return AppPageRoute(
          builder: (c) {
            return HomeScreen(
              controller: controller,
            );
          },
        );
      }
      return null;
    },
  ));
}
