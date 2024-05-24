import 'package:centsei/database/database.dart';
import 'package:centsei/widgets/create_category.dart';
import 'package:flutter/material.dart';
import '../../models/category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    required database
  }) : _database = database;

  final Database _database;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<Category>> _categories;

  @override
  void initState() {
    _categories = widget._database.categories();
    super.initState();
  }

  void updateCategories() {
    setState(() {
      _categories = widget._database.categories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Category>>(
            future: _categories,
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
              }).then((value) {
                updateCategories();
              },);
        }, child: Icon(Icons.add))
      ],
    );
  }
}