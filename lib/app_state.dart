import 'package:centsei/database/Database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/category.dart';

class MyAppState extends ChangeNotifier {
  var title = "Centsei";
  // var categories = <Category>[
  //   Category("Rent", 1898.0),
  //   Category("Groceries", 750.0),
  //   Category("Fun Money", 200.0)
  // ];

  final formatCurrency = NumberFormat.simpleCurrency();
}