import 'package:uuid/v4.dart';

class Transaction {
  UuidV4? id;
  String? description;
  double? amount;

  Transaction(this.description, this.amount) {
    id = UuidV4();
  }
}