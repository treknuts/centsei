import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:centsei/models/transaction.dart';

class MyAppState extends ChangeNotifier {
  var title = "Centsei";
  final formatCurrency = NumberFormat.simpleCurrency();
  var transactions = <Transaction>[];
}