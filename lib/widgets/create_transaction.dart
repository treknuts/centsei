import 'package:flutter/material.dart';

class CreateTransaction extends StatefulWidget {

  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _merchantController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _merchantController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _merchantController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Where was this?'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must have spent money somewhere...';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'What was this for?'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'WHY?!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: '\$4.20'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must provide an amount';
                  } else if (double.tryParse(value)! <= 0) {
                    return 'The number must be greater than or equal to zero';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // var targetAmount = double.parse(_amountController.text);
                      // var newTransaction = Transaction(
                      //   _merchantController.text,
                      //   _descriptionController.text,
                      //   targetAmount,
                      // );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Go!')),
            ],
          ),
        ),
      ],
    );
  }
}
