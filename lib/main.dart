import 'package:api_dummy/view/add.dart';
import 'package:api_dummy/view/index.dart';
import 'package:api_dummy/view/update.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
      '/add-user': (context) => AddUser(),
      '/update-user': (context) => UpdateUser()
    },
    // home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("navbar home"),
        backgroundColor: Color.fromARGB(255, 138, 110, 0),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add-user');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: MyHomePage(),
    );
  }
}
