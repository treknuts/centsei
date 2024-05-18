import 'package:centsei/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Centsei',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var title = "Centsei";
  var categories = <Category>[
    Category("Rent"),
    Category("Groceries"),
    Category("Fun Money")
  ];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = Home();
        break;
      case 1:
        page = CreateTransaction();
        break;
      default:
        throw UnimplementedError("No page implemented for $selectedIndex");
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: page,
          ),
          SafeArea(
            bottom: true,
            child: NavigationBar(
              animationDuration: Duration(milliseconds: 1000),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(icon: Icon(Icons.add), label: "New")
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: ListView.builder(
        itemCount: appState.categories.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.monetization_on_sharp),
              title: Text('${appState.categories[index].title}'),
              trailing: Text('${appState.categories[index].id}'),
            );
          },
      ),
    );
  }
}

class CreateTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Transaction input form'),
    );
  }
}


