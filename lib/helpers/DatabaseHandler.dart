import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler
{
  //CRUD - create, read, update, delete


  Database? db;

  // returntype funname(parama)
  // {
  //   return
  // }

  Future<Database> create_db() async
  {
    //Database create Code
    if(db!=null)
      {
        //If database already created
        return db!;
      }
    else
      {
        //database create
        Directory dir = await getApplicationDocumentsDirectory();
        String dbpath = join(dir.path,"shopping_db");
        var db = await openDatabase(dbpath,version: 1,onCreate: create_tables);
        return db!;
      }
  }

  create_tables(Database db,int version)
  {
    //create Table
    db.execute("create table products (pid integer primary key autoincrement,pcode text,name text,price double,type text,category text)");
    db.execute("create table employee (eid integer primary key autoincrement,ename text,esalary double,egender text,estate text)");
    print("Table Created");
  }


  Future<int> insertproduct(code,name,price,type,category) async
  {
    //create db
    var sdb = await create_db();
    var id = await sdb.rawInsert("insert into products (pcode,name,price,type,category) values (?,?,?,?,?)",[code,name,price,type,category]);
    return id;
  }
  Future<int> insertemployee(ename,sal,gender,state) async
  {
    //create db
    var sdb = await create_db();
    var eid = await sdb.rawInsert("insert into employee (ename,esalary,egender,estate) values (?,?,?,?)",[ename,sal,gender,state]);
    return eid;
  }
  Future<List> viewproduct(type) async
  {
    //create db
    var sdb = await create_db();
    var data;
    if(type=="all")
      {
        data = await sdb.rawQuery("select * from products order by price ASC");
      }
    else
      {
        data = await sdb.rawQuery("select * from products where type=?",[type]);
      }

    return data.toList();
  }
    Future<List> viewemployee() async{
    var sdb = await create_db();
    var eid = await sdb.rawQuery("select * from employee");
    return eid.toList();

    }
  Future<int> deleteproduct(id) async
  {
    //create db
    var sdb = await create_db();
    var status = await sdb.rawDelete("delete from products where pid=?",[id]);
    return status;
  }

  Future<int> deleteemployee(id) async{
    var sdb = await create_db();
    var status = await sdb.rawDelete("delete from employee where eid=?",[id]);
    return status;
  }

  Future<List> getsingleproduct(id) async
  {
    var sdb = await create_db();
    var data = await sdb.rawQuery("select * from products where pid=?",[id]);
    return data.toList();
  }
  Future<int> updateProduct(code,name,price,type,category,id) async
  {
    var sdb = await create_db();
    var status = await sdb.rawUpdate("update products set pcode=?,name=?,price=?,type=?,category=? where pid=?",[code,name,price,type,category,id]);
    return status;
  }

 Future<List> getsingleemployee(id) async{
    var sdb = await create_db();
    var data = await sdb.rawQuery("select * from employee where eid=?",[id]);
    return data.toList();
  }

 Future<int> updateemployee(ename,sal,gender,state,id) async{
    var sdb = await create_db();
    var status = await sdb.rawUpdate("update employee set ename=?,esalary=?,egender=?,estate=? where eid=?",[ename,sal,gender,state,id]);
    return status;
  }

  Future<List> viewsortproduct(type) async
  {
    //create db
    var sdb = await create_db();
    var data;
    if(type=="A to z")
    {
      data = await sdb.rawQuery("select * from products order by name ASC");
    }
    else if(type=="Z to A")
    {
      data = await sdb.rawQuery("select * from products order by name DESC");
    }
    else if(type=="Low to High")
    {
      data = await sdb.rawQuery("select * from products order by price ASC");
    }
    else if(type == "High to Low"){
      data = await sdb.rawQuery("select * from products order by price DESC");
    }
    else
    {
      data = await sdb.rawQuery("select * from products where type=?",[type]);
    }
    return data.toList();
  }
}