import 'package:flutter/material.dart';
import 'package:test_app/location.dart';
import 'package:test_app/views/settings_button.dart';
import '../custom_drawer.dart';

class MapsPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
          title: Text('Map'),
          actions: <Widget>[
            SettingsButton(),
          ],
        ),
      body: Center(
        child: LocationMap(),
      ),
    );
  }
}