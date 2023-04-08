import 'package:flutter/material.dart';

import '../helpers/DatabaseHandler.dart';
import 'UpdateData.dart';

class ViewSortingData extends StatefulWidget {
  const ViewSortingData({Key? key}) : super(key: key);

  @override
  State<ViewSortingData> createState() => _ViewSortingDataState();
}

class _ViewSortingDataState extends State<ViewSortingData> {
  Future<List>? allproducts;

  Future<List> getdata(type) async {
    DatabaseHandler obj = new DatabaseHandler();
    var alldata = await obj.viewsortproduct(type);
    return alldata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allproducts = getdata("A to z");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort Data"),
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                setState(() {
                  allproducts = getdata("A to z");
                });
              } else if (result == 1) {
                setState(() {
                  allproducts = getdata("Z to A");
                });
              } else if (result == 2) {
                setState(() {
                  allproducts = getdata("Low to High");
                });
              }
              else{
                setState(() {
                  allproducts = getdata("High to Low");
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text("A to z")),
              PopupMenuItem(value: 1, child: Text("Z to A")),
              PopupMenuItem(value: 2, child: Text("Low to High")),
              PopupMenuItem(value: 3, child: Text("High to Low")),
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
                                  allproducts = getdata("A to z");
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
