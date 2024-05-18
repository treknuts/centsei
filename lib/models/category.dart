import 'package:centsei/models/transaction.dart';
import 'package:uuid/v4.dart';

class Category {
  UuidV4? id;
  String? title;
  List<Transaction>? transactions;

  Category(String this.title) {
    id = UuidV4();
    transactions = <Transaction>[];
  }

}

