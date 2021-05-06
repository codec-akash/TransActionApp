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
}
