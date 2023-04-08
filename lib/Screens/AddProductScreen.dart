import 'package:flutter/material.dart';
import 'package:soflite/Screens/ViewProductScreen.dart';
import 'package:soflite/helpers/DatabaseHandler.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _productcode = TextEditingController();
  TextEditingController _productname = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  var group = "simple";
  var selected = "Mobilels & Electonic Devices";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Product Code",style: TextStyle(fontSize: 20.0),),
              TextField(
                controller: _productcode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10.0,),
              Text("Product Name",style: TextStyle(fontSize: 20.0),),
              TextField(
                controller: _productname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 10.0,),
              Text("Product Price",style: TextStyle(fontSize: 20.0),),
              TextField(
                controller: _productprice,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Simple",style: TextStyle(fontSize: 15.0),),
                  Radio(value: "simple", groupValue: group, onChanged: (value) {
                    setState(() {
                      group=value!;
                    });
                  },),
                  Text("Variable",style: TextStyle(fontSize: 15.0),),
                  Radio(value: "variable", groupValue: group, onChanged: (value) {
                    setState(() {
                      group=value!;
                    });
                  },),
                ],
              ),
              Row(
                children: [
                  Text("Category: ",style: TextStyle(fontSize: 15.0),),
                  SizedBox(width: 10.0,),
                  DropdownButton(
                    value: selected,
                      items: [
                    DropdownMenuItem(
                      child: Text("Mobilels & Electonic Devices"),
                      value: "Mobilels & Electonic Devices",
                    ),
                        DropdownMenuItem(
                          child: Text("Fashion & Beauty"),
                          value: "Fashion & Beauty",
                        ),
                        DropdownMenuItem(
                          child: Text("Home,Furniture & Application"),
                          value: "Home,Furniture & Application",
                        ),
                        DropdownMenuItem(
                          child: Text("Music,Video and Gaming"),
                          value: "Music,Video and Gaming",
                        ),
                        DropdownMenuItem(
                          child: Text("Books & Education"),
                          value: "Books & Education",
                        ),
                        DropdownMenuItem(
                          child: Text("Office & Professional"),
                          value: "Office & Professional",
                        ),
                  ], onChanged: (value) {
                    setState(() {
                      selected=value!;
                    });
                  },)
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () async
                  {

                    var code = _productcode.text.toString();
                    var name = _productname.text.toString();
                    var price = _productprice.text.toString();
                    var type = group;
                    var category = selected;

                    DatabaseHandler obj = new DatabaseHandler();
                    var pid = await obj.insertproduct(code,name,price,type,category);
                    print("Record inserted : "+pid.toString());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ViewProductScreen(),));

                  }, child: Text("Add")),
                  SizedBox(width: 20.0,),
                  ElevatedButton(onPressed: () {

                  }, child: Text("Cancel"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
