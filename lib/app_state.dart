import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppState extends ChangeNotifier {
  var title = "Centsei";
  final formatCurrency = NumberFormat.simpleCurrency();
}