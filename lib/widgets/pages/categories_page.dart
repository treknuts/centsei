import 'package:centsei/database/database.dart';
import 'package:centsei/widgets/create_category.dart';
import 'package:flutter/material.dart';
import '../../models/category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    required Future<List<Category>> categories,
    required database
  }) : _categories = categories, _database = database;

  final Future<List<Category>> _categories;
  final Database _database;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Category>>(
            future: widget._categories,
            initialData: <Category>[],
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    return Text('Uh oh! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Icon(Icons.monetization_on_outlined),
                          title: Text('${snapshot.data?[index].title}'),
                          // trailing: Text(formatCurrency.format(snapshot.data?[index].target)),
                        );
                      },
                    );
                  } else {
                    return const Text('Create a category to get started!');
                  }
              }
            },
          ),
        ),
        ElevatedButton(onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Center(
                  child: CreateCategory(
                    database: widget._database,
                  ),
                );
              });
        }, child: Icon(Icons.add))
      ],
    );
  }
}