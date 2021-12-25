import 'package:flutter/material.dart';


String? token ;

bool connected = false;

Color defultColor = Colors.indigo;

void printFullData(String text){
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}