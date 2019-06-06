import 'package:flutter/material.dart';
import './pages/maps.dart';
import './pages/home.dart';
import './pages/albums.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('Posts'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Albums'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Maps'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MapsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
