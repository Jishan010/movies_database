import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Please enter details to register",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32),
                GestureDetector(
                  onTap: () async {
                    // Perform registration logic here
                    String email = emailController.text;
                    String password = passwordController.text;
                    await _saveCredentials(email, password);
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
                    child: Text("REGISTER"),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                    onPressed: () {
                      Beamer.of(context).beamToNamed(
                        '/login',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
