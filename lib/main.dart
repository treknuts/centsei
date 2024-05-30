import 'package:centsei/database/database.dart';
import 'package:centsei/router.dart';
import 'package:centsei/widgets/pages/categories_page.dart';
import 'package:centsei/widgets/pages/transactions_page.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:centsei/app_state.dart';

import 'authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: ((context, child) => const MyApp()),
    ),
  );
}

final _router = getRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp.router(
      title: 'Centsei',
      theme: theme,
      routerConfig: _router,
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
    var state = context.watch<ApplicationState>();
    var database = state.database;

    switch (selectedIndex) {
      case 0:
        page = Home(database: database);
        break;
      case 1:
        page = CategoryList(database: database);
        break;
      case 2:
        page = TransactionList(database: database);
      case 3:
        if (state.loggedIn) {
          page = ProfileScreen(
            providers: const [],
            actions: [
              SignedOutAction((context) {
                context.pushReplacement('/');
              })
            ],
          );
        } else {
          page = SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                final uri = Uri(
                  path: '/sign-in/forgot-password',
                  queryParameters: <String, String?>{
                    'email': email,
                  },
                );
                context.push(uri.toString());
              })),
              AuthStateChangeAction(((context, state){
                final user = switch(state) {
                  SignedIn state => state.user,
                  UserCreated state => state.credential.user,
                  _ => null
                };

                if (user == null) {
                  return;
                }

                if (state is UserCreated) {
                  user.updateDisplayName(user.email!.split('@')[0]);
                }

                if (!user.emailVerified) {
                  user.sendEmailVerification();
                  const snackBar = SnackBar(
                    content: Text('Check your email to verify account!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                context.pushReplacement('/');
              })),
            ],
          );
        }
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
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: Icon(Icons.category),
                  label: "Categories",
                ),
                NavigationDestination(
                  icon: Icon(Icons.monetization_on_rounded),
                  label: "Transactions",
                ),
                NavigationDestination(
                  icon: state.loggedIn ? Icon(Icons.person) : Icon(Icons.login),
                  label: state.loggedIn ? "Profile" : "Login",
                )
                // Consumer<ApplicationState>(
                //   builder: (context, appState, _) => AuthFunc(
                //       loggedIn: appState.loggedIn,
                //       signOut: () {
                //         FirebaseAuth.instance.signOut();
                //       }),
                // ),
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
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
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
