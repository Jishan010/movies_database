import 'package:flutter/material.dart';
import 'package:movies_database/src/screens/home_screen.dart';

class App extends StatelessWidget {

  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
