import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_app/services/itemservice.dart';

class EditItemScreen extends StatefulWidget {
  late String documentid;
  final _itemName = TextEditingController();
  final _itemEffects = TextEditingController();
  final _itemSpecialEffects = TextEditingController();
  final _itemCategory = TextEditingController();

  EditItemScreen(String documentid, String itemname, String itemEffects,
      String itemSpecialEffects, String itemCategory) {
    documentid = documentid;
    _itemName.text = itemname;
    _itemEffects.text = itemEffects;
    _itemSpecialEffects.text = itemSpecialEffects;
    _itemCategory.text = itemCategory;
  }

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._itemName,
              decoration: const InputDecoration(label: Text("Item name")),
              readOnly: true,
            ),
            TextField(
              controller: widget._itemEffects,
              decoration: const InputDecoration(label: Text("Effects")),
            ),
            TextField(
              controller: widget._itemSpecialEffects,
              decoration: InputDecoration(label: Text("Special Effects")),
            ),
            TextField(
              controller: widget._itemCategory,
              decoration: InputDecoration(label: Text("Category")),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: _deleteItem, child: const Text("Delete")),
            ),
            ElevatedButton(onPressed: _editItem, child: const Text("Edit"))
          ],
        ),
      ),
    );
  }

  void _editItem() {
    _itemService.editItem(widget._itemName.text, {
      "name": widget._itemName.text,
      "Effects": widget._itemEffects.text,
      "SpecialEffects": widget._itemSpecialEffects.text,
      "Category": widget._itemCategory.text
    });
  }

  void _deleteItem() {
    _itemService.deleteItem(widget._itemName.text);
  }
}
