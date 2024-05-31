import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? id;
  String? title;
  double? target;
  double? actual;

  Category({
    this.id,
    this.title,
    this.target,
    this.actual,
  });

  factory Category.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return Category(
      id: data?['id'],
      title: data?['title'],
      target: data?['target'],
      actual: data?['actual'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id":id,
      if (title != null) "title":title,
      if (target != null) "target":target,
      if (actual != null) "actual":actual,
    };
  }
}

