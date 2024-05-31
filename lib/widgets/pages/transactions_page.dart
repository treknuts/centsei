import 'package:flutter/material.dart';
import 'package:centsei/models/transaction.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    required this.transactions,
  });

  final List<Transaction> transactions;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        for (var message in widget.transactions)
          Text('${message.merchant}: ${message.amount}'),
        const SizedBox(height: 8),
      ],
      // ...to here.
    );
  }
}
