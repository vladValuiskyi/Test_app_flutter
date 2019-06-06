
import 'package:flutter/material.dart';
import './pages/home.dart';

void main() {
  //MapView.setApiKey('AIzaSyBbsQFZWDBucONP3nXnFKiFvlYhgaUA_uw');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //List<Post> _posts = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      home: HomePage(),
    );
  }
}
