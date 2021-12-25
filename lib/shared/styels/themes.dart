import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() 
{
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.indigo,
      fontFamily: 'Amaranth',
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black)),
      appBarTheme: const AppBarTheme(
          titleSpacing: 20,
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          color: Colors.white,
          elevation: 0.0),
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //     backgroundColor: Colors.white,
      //     selectedIconTheme: IconThemeData(color: Colors.deepOrange))
      );
}

ThemeData darkTheme() 
{
  return ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(27, 38, 49, 1),
      primarySwatch: Colors.indigo,
      fontFamily: 'Amaranth',
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white)),
      appBarTheme: const AppBarTheme(
          titleSpacing: 20,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(27, 38, 49, 1),
              statusBarIconBrightness: Brightness.light),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          color: Color.fromRGBO(27, 38, 49, 1),
          elevation: 0.0),
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //     backgroundColor: Color.fromRGBO(27, 38, 49, 1),
      //     unselectedItemColor: Colors.grey,
      //     selectedIconTheme: IconThemeData(color: Colors.deepOrange))
          );
}
