import 'package:flutter/material.dart';
import 'package:test_app/views/settings_button.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          SettingsButton(),
        ],
      ),
      body: Center(
        child: Text("This is settings page!!!"),
      ),
    );
  }
}
