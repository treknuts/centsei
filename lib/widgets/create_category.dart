import 'package:centsei/main.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';
import '../database/database.dart';
import '../models/category.dart';

class CreateCategory extends StatefulWidget {
  final Database database;

  const CreateCategory({super.key, required this.database});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
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

                        var newCat = Category(_nameController.text, targetAmount);
                        widget.database.insertCategory(newCat);
                        print(newCat.id.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Creating Category: ${_nameController.text}')
                            )
                        );
                        Navigator.pop(context);
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