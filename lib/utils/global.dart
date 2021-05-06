import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
  TextStyle headerText = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle subHeaderText = TextStyle(
    fontSize: 18.0,
  );

  TextStyle titleText = TextStyle(
      fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w400);

  BorderRadiusGeometry borderRadius = BorderRadius.circular(10.0);

  InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  BoxDecoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.black, width: 2.0),
  );
}
