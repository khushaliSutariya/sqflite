import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:soflite/Screens/UpdateEmployeeData.dart';
import 'package:soflite/helpers/DatabaseHandler.dart';

class ViewEmployeeScreen extends StatefulWidget {
  const ViewEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<ViewEmployeeScreen> createState() => _ViewEmployeeScreenState();
}

class _ViewEmployeeScreenState extends State<ViewEmployeeScreen> {
  Future<List>? allemployee;
  Future<List> getemployeedata() async {
    DatabaseHandler obj = new DatabaseHandler();
    var empdata = await obj.viewemployee();
    return empdata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      allemployee = getemployeedata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Employee"),
        ),
        body: FutureBuilder(
          future: allemployee,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return Text("No Data Found");
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.deepOrange.shade200,
                        child: Card(
                          elevation: 5.0,
                          color: Colors.amber.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Employee Name: " +
                                    snapshot.data![index]["ename"].toString()),
                                Text("Employee Salary: " +
                                    snapshot.data![index]["esalary"]
                                        .toString()),
                                Text("Gender: " +
                                    snapshot.data![index]["egender"]
                                        .toString()),
                                Text("Employee State: " +
                                    snapshot.data![index]["estate"].toString()),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          var id = snapshot.data![index]["eid"]
                                              .toString();
                                          DatabaseHandler obj =
                                              new DatabaseHandler();
                                          var st = await obj.deleteemployee(id);
                                          if (st == 1) {
                                            setState(() {
                                              allemployee = getemployeedata();
                                            });
                                          } else {
                                            FlutterToastr.show(
                                                "Record not deleted", context,
                                                duration:
                                                    FlutterToastr.lengthShort,
                                                position: FlutterToastr.bottom);
                                          }
                                        },
                                        child: Text("Delete")),
                                    ElevatedButton(
                                        onPressed: () {
                                          var id = snapshot.data![index]["eid"].toString();
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateEmployeeData(
                                                    updateempid: id),
                                          ));
                                        },
                                        child: Text("Update")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
