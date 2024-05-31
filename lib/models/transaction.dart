import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  String? merchant;
  String? description;
  double? amount;

  Transaction({
   this.merchant,
   this.description,
   this.amount
  });

  factory Transaction.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return Transaction(
      merchant: data?['merchant'],
      description: data?['description'],
      amount: data?['amount']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (merchant != null) "merchant":merchant,
      if (description != null) "description":description,
      if (amount != null) "amount":amount,
    };
  }

}