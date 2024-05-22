import 'package:centsei/models/transaction.dart';
import 'package:uuid/v4.dart';

class Category {
  UuidV4 id;
  String? title;
  List<Transaction>? transactions;
  late double target;
  double? actual;

  Category(this.id, this.title, this.target) {
    actual = 0.0;
  }

  Map<String, Object?> toMap() {
    return {
      'id': id.generate(),
      'title': title,
      'target': target,
      'actual': actual
    };
  }

  @override
  String toString() {
    return 'Category{title: $title, target: $target, actual: $actual"}';
  }

}

