import 'package:flutter/material.dart';
// Todo Custom Margin Height
// ignore: non_constant_identifier_names
double custom_height(BuildContext context, double margin) {
  Size size = MediaQuery.of(context).size;
  return (margin * size.height) / 100;
}

// Todo Custom Margin Width
// ignore: non_constant_identifier_names
double custom_width(BuildContext context, double margin) {
  Size size = MediaQuery.of(context).size;
  return (margin * size.width) / 100;
}
