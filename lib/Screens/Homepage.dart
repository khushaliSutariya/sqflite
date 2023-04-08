import 'package:flutter/material.dart';
import 'package:soflite/Screens/AddEmployeeScreen.dart';
import 'package:soflite/Screens/AddProductScreen.dart';
import 'package:soflite/Screens/ViewEmployeeScreen.dart';
import 'package:soflite/Screens/ViewProductScreen.dart';
import 'package:soflite/Screens/ViewSortingData.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqf Lite"),
      ),
      body: Column(
        children: [],
      ),
      drawer: Drawer(
        child: ListView(
          padding:  EdgeInsets.only(top: 35.0, left: 20.0),
          children: [
            ListTile(
              title:  Text('Add Product'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ));
              },
            ),
            ListTile(
              title:  Text('View Product'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewProductScreen(),
                ));
              },
            ),
            ListTile(
              title:  Text('Add Employee'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEmployeeScreen(),
                ));
              },
            ),
            ListTile(
              title:  Text('View Employee'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewEmployeeScreen(),
                ));
              },
            ),
            ListTile(
              title:  Text('View Sort Product'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewSortingData(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
