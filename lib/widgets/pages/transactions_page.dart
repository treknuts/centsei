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

    return ListView.builder(
      itemCount: state.transactions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text(
            "-${state.formatCurrency.format(state.transactions[index].amount)}",
          ),
          title: Text("${state.transactions[index].merchant}"),
          trailing: Icon(Icons.trending_down),
        );
      },
    );
  }
}