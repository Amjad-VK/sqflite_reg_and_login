// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_reg_and_login/Sqlhelper.dart';
import 'package:sqflite_reg_and_login/landpage.dart';
import 'package:sqflite_reg_and_login/login.dart';

class signup_pg extends StatefulWidget {
  const signup_pg({super.key});

  @override
  State<signup_pg> createState() => _signup_pgState();
}

class _signup_pgState extends State<signup_pg> {
  var formkey = GlobalKey<FormState>();
  var conname = TextEditingController();
  var conemail = TextEditingController();
  var pass = TextEditingController();
  var cpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void AddNewUser(String name, String email, String password) async {
      var id = await SQLhelper.AddNewUser(name, email, password);

      if (id != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => loginpg()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => landpage()));
      }
    }

    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign Up'),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name', border: OutlineInputBorder()),
                  controller: conname,
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Name is Required';
                    } else
                      return null;
                  },
                )),
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
                )),
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder()),
                  controller: cpass,
                  validator: (conpass) {
                    if (conpass!.isEmpty || conpass.length < 6) {
                      return 'Password Too Short or Empty';
                    } else if (cpass.text != pass.text) {
                      return 'Password Not Matched';
                    } else {
                      return null;
                    }
                  },
                )),
            ElevatedButton(
                onPressed: () async {
                  final valid = formkey.currentState!.validate();
                  if (valid) {
                    String uname = conemail.text;
                    String name = conname.text;

                    var data = await SQLhelper.userFound(name, uname);

                    if (data.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('user already exist')));
                    } else {
                      AddNewUser(conname.text, conemail.text, pass.text);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        action: SnackBarAction(label: 'UNDO', onPressed: () {}),
                        content: const Text('Invalid username / password')));
                  }
                },
                child: Text('SignUp')),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextButton(
                  onPressed: () {
                    loginpg();
                  },
                  child: Text('Already Have an Account ? Login')),
            )
          ],
        ),
      ),
    );
  }
}
