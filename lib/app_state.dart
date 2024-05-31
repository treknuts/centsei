import 'dart:async';

import 'package:centsei/firebase_options.dart';
import 'package:centsei/models/transaction.dart' as custom;
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  var title = "Centsei";
  final formatCurrency = NumberFormat.simpleCurrency();
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  StreamSubscription<QuerySnapshot>? _transactionSubscription;
  List<custom.Transaction> _transactions = [];
  List<custom.Transaction> get transactions => _transactions;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _transactionSubscription = FirebaseFirestore.instance
            .collection('transactions')
            .snapshots()
            .listen((snapshot) {
          _transactions = [];
          for (final transaction in snapshot.docs) {
            _transactions.add(
              custom.Transaction(
                merchant: transaction.data()['merchant'] as String,
                description: transaction.data()['description'] as String,
                amount: transaction.data()['amount'] as double
              )
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _transactions = [];
        _transactionSubscription?.cancel();
      }
      notifyListeners();
    });
  }
}
