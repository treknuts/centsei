import 'package:centsei/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart'
                hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:centsei/models/transaction.dart';
import 'package:centsei/database/database.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  var title = "Centsei";
  final Database database = Database();
  final formatCurrency = NumberFormat.simpleCurrency();
  var transactions = <Transaction>[];
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
  
}