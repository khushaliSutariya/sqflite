import 'package:flutter/material.dart';
import 'package:soflite/Screens/UpdateData.dart';

import '../helpers/DatabaseHandler.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  Future<List>? allproducts;

  Future<List> getdata(type)async {
    DatabaseHandler obj = new DatabaseHandler();
    var alldata = await obj.viewproduct(type);
    return alldata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproducts = getdata("all");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product"),
        actions: [
          PopupMenuButton(
            onSelected: (result) {


            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: Text("A to z")),
              PopupMenuItem(
                  value: 1,
                  child: Text("Z to A")),

            ],
          ),
          PopupMenuButton(
            onSelected: (result) {
             if(result==0)
               {
                 setState(() {
                   allproducts = getdata("all");
                 });
               }
             else if(result==1)
               {
                 setState(() {
                   allproducts = getdata("simple");
                 });
               }
             else
               {
                 setState(() {
                   allproducts = getdata("variable");
                 });
               }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                  child: Text("All")),
              PopupMenuItem(
                value: 1,
                  child: Text("Simple")),
              PopupMenuItem(
                value: 2,
                  child: Text("Variable")),
            ],
          ),

        ],
      ),
      body: FutureBuilder(
        future: allproducts,
        builder: (context, snapshots) {
          if (snapshots.hasData) // check data loaded
          {
            if (snapshots.data!.length == 0) {
              return Center(
                child: Text("No Data Found!"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    margin: EdgeInsets.all(10.0),
                    color: Colors.red.shade100,
                    child: Column(
                      children: [
                        // CircleAvatar(
                        //   child: Text(snapshots.data![index]["pcode"][0].toString().toUpperCase()),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pcode: " +
                                  snapshots.data![index]["pcode"].toString()),
                              Text("Name: " +
                                  snapshots.data![index]["name"].toString()),
                              Text("Price: " +
                                  snapshots.data![index]["price"].toString()),
                              Text("Type: " +
                                  snapshots.data![index]["type"].toString()),
                              Text("Category: " +
                                  snapshots.data![index]["category"]
                                      .toString()),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var id = snapshots.data![index]["pid"].toString();
                              DatabaseHandler obj = new DatabaseHandler();
                              var st = await obj.deleteproduct(id);
                              if (st == 1) {
                                print("Record Deleted");
                                setState(() {
                                  allproducts = getdata("all");
                                });
                              } else {
                                print("Record not Deleted");
                              }
                            },
                            child: Icon(Icons.delete)),
                        ElevatedButton(
                            onPressed: () {
                              var id = snapshots.data![index]["pid"].toString();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateData(
                                  updateid: id,
                                ),
                              ));
                            },
                            child: Text("Update")),
                      ],
                    ),
                  );
                  // return ListTile(
                  //   title: Text(snapshots.data![index]["pcode"].toString()),
                  //   subtitle: Text(snapshots.data![index]["name"].toString()),
                  //   trailing: Text("Rs."+snapshots.data![index]["price"].toString()),
                  // );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
