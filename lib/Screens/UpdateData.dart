import 'package:flutter/material.dart';
import 'package:soflite/Screens/ViewProductScreen.dart';
import 'package:soflite/helpers/DatabaseHandler.dart';

class UpdateData extends StatefulWidget {

  var updateid="";
  UpdateData({required this.updateid});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController _productcode = TextEditingController();
  TextEditingController _productname = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  var group = "simple";
  var selected = "Mobilels & Electonic Devices";

  getsingle() async
  {
    DatabaseHandler obj = new DatabaseHandler();
    var data = await obj.getsingleproduct(widget.updateid);
    setState(() {
      _productcode.text = data[0]["pcode"].toString();
      _productname.text = data[0]["name"].toString();
      _productprice.text = data[0]["price"].toString();
      group= data[0]["type"].toString();
      selected= data[0]["category"].toString();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
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
                    var status = await obj.updateProduct(code,name,price,type,category,widget.updateid);
                    if(status==1)
                      {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ViewProductScreen(),));
                      }
                    else
                      {
                        print("Error");
                      }

                  }, child: Text("Save")),
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
