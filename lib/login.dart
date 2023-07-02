import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_reg_and_login/Sqlhelper.dart';
import 'package:sqflite_reg_and_login/admin.dart';
import 'package:sqflite_reg_and_login/home.dart';
import 'package:sqflite_reg_and_login/landpage.dart';

class loginpg extends StatefulWidget {
  const loginpg({super.key});

  @override
  State<loginpg> createState() => _loginpgState();
}

class _loginpgState extends State<loginpg> {
  var formkey = GlobalKey<FormState>();
  var conemail = TextEditingController();
  var pass = TextEditingController();

  void logincheck(String email, String password) async {
    if (email == 'admin@gmail.com' && password == '123456') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => admin_home()));
    } else {
      var data = await SQLhelper.Checklogin(email, password);
      if (data.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => home_user(data: data,)));
        print('Login Success');
      } else if (data.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => landpage()));
        print('Login failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email', border: OutlineInputBorder()),
                controller: conemail,
                validator: (email) {
                  if (email!.isEmpty ||
                      !email.contains('@') ||
                      !email.contains('.')) {
                    return 'Enter valid email';
                  } else
                    return null;
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password', border: OutlineInputBorder()),
                  controller: pass,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return 'Password Too Short or Empty';
                    } else
                      return null;
                  },
                )),
            ElevatedButton(
                onPressed: () {
                  final valid = formkey.currentState!.validate();
                  if (valid) {
                    logincheck(conemail.text, pass.text);
                  } else {}
                },
                child: Text('Login')),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextButton(
                  onPressed: () {}, child: Text('Not A User ? Register here')),
            )
          ],
        ),
      ),
    );
  }
}
