import 'package:centsei/database/database.dart';
import 'package:centsei/models/category.dart';
import 'package:centsei/widgets/pages/categories_page.dart';
import 'package:centsei/widgets/pages/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:centsei/app_state.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    var theme = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue));

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Centsei',
        theme: theme,
        home: const MyHomePage(index: 0,),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required index});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    var state = context.watch<MyAppState>();
    var database = state.database;

    switch (selectedIndex) {
      case 0:
        page = Home(database: database);
        break;
      case 1:
        page = CategoryList(categories: database.categories(), database: database,);
        break;
      case 2:
        page = TransactionList();
      default:
        throw UnimplementedError("No page implemented for $selectedIndex");
    }
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            leading: Icon(Icons.monetization_on_outlined,
                color: Theme.of(context).colorScheme.onPrimary),
            title: Text("Centsei",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          ),
          Expanded(
            child: page,
          ),
          SafeArea(
            bottom: true,
            child: NavigationBar(
              animationDuration: Duration(milliseconds: 1000),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(icon: Icon(Icons.category), label: "Categories"),
                NavigationDestination(icon: Icon(Icons.monetization_on_rounded), label: "Transactions")
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

class Home extends StatefulWidget {
  final Database database;
  const Home({super.key, required this.database});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Category>> _categories;
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    _categories = widget.database.categories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.emoji_events_outlined,
        size: 92.0,
      ),
    );
  }
}




