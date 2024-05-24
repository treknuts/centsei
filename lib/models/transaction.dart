import 'package:uuid/v4.dart';

class Transaction {
  UuidV4? id;
  String? merchant;
  String? description;
  double? amount;

  Transaction(this.merchant, this.description, this.amount) {
    id = UuidV4();
  }

  Map<String, Object?> toMap() {
    return {
      'id': id?.generate(),
      'merchant': merchant,
      'description': description,
      'amount': amount
    };
  }

  @override
  String toString() {
    return 'Transaction{merchant: $merchant, description: $description, amount: $amount"}';
  }
}