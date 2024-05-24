import 'package:centsei/models/transaction.dart';
import 'package:centsei/widgets/create_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    var database = state.database;
    var transactions = database.transactions();

    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Transaction>>(
            future: transactions,
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
                  onPressed: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CreateTransaction(
                              database: database,
                            ),
                          );
                        });
                  },
                  child: Icon(Icons.add)),
            ),
          ],
        )
      ],
    );
  }
}
