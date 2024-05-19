import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../../models/category.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Category Name...'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a name for this Category';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '\$400.00'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a name for this Category';
                    } else if (double.tryParse(value) == null) {
                      return 'Please provide a valid number';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var targetAmount = double.parse(_targetController.text);
                        appState.categories.add(
                            Category(_nameController.text, targetAmount)
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Creating Category: ${_nameController.text}')
                            )
                        );
                      }
                    },
                    child: Text('Go!')
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}