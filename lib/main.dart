import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_flutter_app/screens/create_account_screen.dart';
import 'package:project_flutter_app/screens/login_screen.dart';
import 'package:project_flutter_app/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

import 'package:project_flutter_app/screen/new_item_screen.dart';

import 'screen/edit_item_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthService _service = AuthService();

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(19, 229, 170, 1)),
                child: Text("Welcome\n$displayEmail")),
            ListTile(
              title: const Text("เพิ่มไอเทม"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewItemScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("ออกจากระบบ"),
              onTap: () {
                _service.logout(currentUser);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataDocuments[index]["name"].toString()),
                subtitle: Text(
                  'Effects : ' +
                      dataDocuments[index]["Effects"].toString() +
                      "\nSpecialEffects : " +
                      dataDocuments[index]["SpecialEffects"].toString() +
                      "\nCategory : " +
                      dataDocuments[index]["Category"].toString(),
                ),
                onTap: () => _editItemScreen(
                    dataDocuments[index].id,
                    dataDocuments[index]["name"],
                    dataDocuments[index]["Effects"],
                    dataDocuments[index]["SpecialEffects"],
                    dataDocuments[index]["Category"]),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'Create New Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  _editItemScreen(String documentid, String itemName, String itemEffects,
      String itemSpecialEffects, itemCategory) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditItemScreen(documentid, itemName,
                itemEffects, itemSpecialEffects, itemCategory)));
  }
}
