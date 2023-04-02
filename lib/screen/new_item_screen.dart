import 'package:flutter/material.dart';
import 'package:project_flutter_app/services/itemservice.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _itemName = TextEditingController();
  final _itemEffects = TextEditingController();
  final _itemSpecialEffects = TextEditingController();
  final _itemCategory = TextEditingController();

  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มไอเทม"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemName,
              decoration: InputDecoration(label: Text("name")),
            ),
            TextField(
              controller: _itemEffects,
              decoration: InputDecoration(label: Text("เอฟเฟกต์")),
            ),
            TextField(
              controller: _itemSpecialEffects,
              decoration: InputDecoration(label: Text("Special Effects")),
            ),
            TextField(
              controller: _itemCategory,
              decoration: InputDecoration(label: Text("Category")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _addItem, child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  _addItem() {
    _itemService.addItem2Firebase(_itemName.text, {
      "name": _itemName.text,
      "Effects": _itemEffects.text,
      "SpecialEffects": _itemSpecialEffects.text,
      "Category": _itemCategory.text
      //"Category": _itemCategory.text
    });
  }
}
