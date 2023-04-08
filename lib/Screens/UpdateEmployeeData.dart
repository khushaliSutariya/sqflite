import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../helpers/DatabaseHandler.dart';
import 'ViewEmployeeScreen.dart';

class UpdateEmployeeData extends StatefulWidget {
  var updateempid = '';
  UpdateEmployeeData({required this.updateempid});
  @override
  State<UpdateEmployeeData> createState() => _UpdateEmployeeDataState();
}

class _UpdateEmployeeDataState extends State<UpdateEmployeeData> {
  TextEditingController _employee = TextEditingController();
  TextEditingController _salary = TextEditingController();
  var group = "Male";
  var selected = "Gujrat";

  getemployee() async {
    DatabaseHandler obj = new DatabaseHandler();
    var edata = await obj.getsingleemployee(widget.updateempid);
    setState(() {
      _employee.text = edata[0]["ename"].toString();
      _salary.text = edata[0]["esalary"].toString();
      group = edata[0]["egender"].toString();
      selected = edata[0]["estate"].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getemployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPdate Employee"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Employee Name",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _employee,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Employee Salary",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _salary,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Gender: "),
                  Text(
                    "Male",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Radio(
                    value: "Male",
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value!;
                      });
                    },
                  ),
                  Text(
                    "Female",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Radio(
                    value: "Female",
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        group = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "State: ",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  DropdownButton(
                    value: selected,
                    items: [
                      DropdownMenuItem(
                        child: Text("Gujrat"),
                        value: "Gujrat",
                      ),
                      DropdownMenuItem(
                        child: Text("Punjab"),
                        value: "Punjab",
                      ),
                      DropdownMenuItem(
                        child: Text("Haryana"),
                        value: "Haryana",
                      ),
                      DropdownMenuItem(
                        child: Text("Goa"),
                        value: "Goa",
                      ),
                      DropdownMenuItem(
                        child: Text("karnataka"),
                        value: "karnataka",
                      ),
                      DropdownMenuItem(
                        child: Text("Maharashtra"),
                        value: "Maharashtra",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selected = value!;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var ename = _employee.text.toString();
                        var sal = _salary.text.toString();
                        var gender = group;
                        var state = selected;

                        DatabaseHandler obj = new DatabaseHandler();
                        var estatus = await obj.updateemployee(
                            ename, sal, gender, state, widget.updateempid);
                        if (estatus == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewEmployeeScreen(),
                          ));
                        } else {
                          FlutterToastr.show(
                              "Record not updated",
                              context,
                              duration: FlutterToastr.lengthShort,
                              position: FlutterToastr.bottom);
                        }
                      },
                      child: Text("Save")),
                  SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewEmployeeScreen(),
                        ));
                      },
                      child: Text("Cancel"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
