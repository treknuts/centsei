import 'package:centsei/database/Database.dart';
import 'package:centsei/models/category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:centsei/widgets/pages/create_category_page.dart';
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
        home: const MyHomePage(),
      ),
    );
  }
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

    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    switch (selectedIndex) {
      case 0:
        page = Home();
        break;
      case 1:
        page = CreateCategory();
        break;
      default:
        throw UnimplementedError("No page implemented for $selectedIndex");
    }
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: (mWidth / 2) - 45, bottom: 40),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Center(
                    child: Text(
                      "Peekaboo!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  );
                });
          },
        ),
      ),
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

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CentseiDatabase database = CentseiDatabase();
  late Future<List<Category>> _categories;
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    _categories = database.categories();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
            return CircularProgressIndicator();
          }
        },
      ),
    );

    // return Center(
    //   child: ListView.builder(
    //     itemCount: _categories.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return ListTile(
    //         leading: Icon(Icons.monetization_on_sharp),
    //         title: Text('${_categories[index].title}'),
    //         trailing: Text(appState.formatCurrency
    //             .format(_categories[index].target)),
    //       );
    //     },
    //   ),
    // );
  }
}
