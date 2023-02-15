import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _pageLogin = true;

  // bool _rememberPassword = false;

  void _togglePage(bool _switchme) {
    setState(
      () {
        _pageLogin = _switchme;
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text("Login",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 4),
                Text(
                  "Please login to your account",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    print(nameController.text);
                    print(passwordController.text);
                    Beamer.of(context).beamToNamed(
                      '/home',
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text("LOGIN"),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        //signup screen
                        Beamer.of(context).beamToNamed(
                          '/registration',
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
