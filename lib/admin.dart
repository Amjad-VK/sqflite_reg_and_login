import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_reg_and_login/Sqlhelper.dart';

class admin_home extends StatefulWidget {
  const admin_home({Key? key}) : super(key: key);

  @override
  State<admin_home> createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  var data;
  void delet(int id)async {
   await SQLhelper.Deleteuser(id);
   Refresh();
  }
  @override
  void initState() {
   Refresh();
    super.initState();
  }
  void Refresh() async{
    var mydata  = await SQLhelper.getAll();
    setState(()   {
      data = mydata;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel'),),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,int index){
        return Card(
          color: Colors.deepPurple[200],
          child: ListTile(
            title: Text('${data[index]['name']}'),
            trailing: IconButton(onPressed: (){
              delet(data[index]['id']);
            },icon: Icon(Icons.delete),),
          ),
        );
      }),
    );
  }
}
