import 'dart:async';

import 'package:centsei/models/transaction.dart';
import 'package:centsei/widgets/create_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../../database/database.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    required database,
  }) : _database = database;

  final Database _database;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late Future<List<Transaction>> _transactions;

  @override
  void initState() {
    _transactions = widget._database.transactions();
    super.initState();
  }

  void updateTransactions() {
    setState(() {
      _transactions = widget._database.transactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();

    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Transaction>>(
            future: _transactions,
            initialData: <Transaction>[],
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Uh oh! Something went horribly wrong...'));
              }

              if (!snapshot.hasData) {
                return const Center(
                    child: Text('Create a category to get started!'));
              }

              List<Transaction> transactions = snapshot.data as List<Transaction>;
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    key: ValueKey(transactions[index].id),
                    leading: Text('${transactions[index].merchant}'),
                    title: Text('${transactions[index].description}'),
                    trailing: Text(
                        '-${state.formatCurrency.format(transactions[index].amount)}'),
                  );
                },
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CreateTransaction(
                              database: widget._database,
                            ),
                          );
                        }).then((value) {
                          updateTransactions();
                        },);
                  },
                  child: Icon(Icons.add)),
            ),
          ],
        )
      ],
    );
  }
}
