import 'package:flutter_application_1/pages/ManualAccesibidad.dart';
import 'package:flutter_application_1/pages/ManualProgramador.dart';

import 'pages/checkout.dart';
import 'pages/shop_items.dart';
import 'pages/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(21, 35, 38, .1),
      100: Color.fromRGBO(21, 35, 38, .2),
      200: Color.fromRGBO(21, 35, 38, .3),
      300: Color.fromRGBO(21, 35, 38, .4),
      400: Color.fromRGBO(21, 35, 38, .5),
      500: Color.fromRGBO(21, 35, 38, .6),
      600: Color.fromRGBO(21, 35, 38, .7),
      700: Color.fromRGBO(21, 35, 38, .8),
      800: Color.fromRGBO(21, 35, 38, .9),
      900: Color.fromRGBO(21, 35, 38, 1),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF152326, color),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => Login(),
        '/': (BuildContext context) => ShopItems(),
        '/checkout': (BuildContext context) => Checkout(),
        '/accesibilidad': (BuildContext context) => ManualAccesibilidad(),
        '/programador': (BuildContext context) => ManualProgramador()
      },
    );
  }
}
