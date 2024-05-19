import 'package:centsei/models/transaction.dart';
import 'package:uuid/v4.dart';

class Category {
  UuidV4? id;
  String? title;
  List<Transaction>? transactions;
  late double target;
  double? actual;

  Category(String this.title, this.target) {
    id = UuidV4();
    transactions = <Transaction>[];
    actual = 0.0;
  }

}

