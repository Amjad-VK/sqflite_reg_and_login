import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_reg_and_login/login.dart';
import 'package:sqflite_reg_and_login/signup.dart';

class landpage extends StatefulWidget {
  const landpage({super.key});

  @override
  State<landpage> createState() => _landpageState();
}

class _landpageState extends State<landpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.supervised_user_circle_sharp,
              size: 80,
            ),
            Text(
              'Hello',
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const loginpg()),
                    );
                  },
                  child: Text('Login')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const signup_pg()),
                    );
                  },
                  child: Text('SignUp')),
            ),
            
          ],
        ),
      ),
    );
  }
}
