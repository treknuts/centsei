import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:centsei/models/transaction.dart';
import 'package:centsei/database/database.dart';

class MyAppState extends ChangeNotifier {
  var title = "Centsei";
  final Database database = Database();
  final formatCurrency = NumberFormat.simpleCurrency();
  var transactions = <Transaction>[];
}