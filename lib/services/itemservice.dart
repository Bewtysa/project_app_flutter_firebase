// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  Future<void> addItem2Firebase(String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("items")
        .doc(documentid)
        .set(data)
        .then((value) {
      print("Item created");
    }).catchError((error) {
      print("Can't create item:" + error.toString());
    });
  }

  Future<void> editItem(String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("items")
        .doc(documentid)
        .update(data)
        .then((value) {
      print("Item update");
    }).catchError((error) {
      print("Can't update item:" + error.toString());
    });
  }

  Future<void> deleteItem(String documentid) {
    return FirebaseFirestore.instance
        .collection("items")
        .doc(documentid)
        .delete()
        .then((value) {
      print("Item deleted");
    }).catchError((error) {
      print("Can't delete item:" + error.toString());
    });
  }
}
