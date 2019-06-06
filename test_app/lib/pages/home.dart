import 'package:flutter/material.dart';
import 'package:test_app/api/api.dart';
import 'package:test_app/models/comment.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/views/settings_button.dart';
import '../custom_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text('Posts'),
          actions: <Widget>[
            SettingsButton(),
          ],
        ),
        body: FutureBuilder<Map<Post, List<Comment>>>(
          future: ApiRequests().getPostsWithComments(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: viewPostsWithComments(snapshot),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  List<Container> viewPostsWithComments(AsyncSnapshot snapshot) {
    Map<Post, List<Comment>> map = snapshot.data;
    List<Container> containers = [];
    map.forEach((Post post, List<Comment> comments) {
      containers.add(Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    post.body,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Comments",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Column(
                          children: viewComments(comments),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    });
    return containers;
  }

  List<Container> viewComments(List<Comment> comments) {
    List<Container> containers = [];
    if (comments != null) {
      comments.forEach((Comment comment) {
        containers.add(Container(
          child: Column(
            children: <Widget>[
              ExpansionTile(
                title: Text(comment.email),
                children: <Widget>[
                  Text(
                    comment.body,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ));
      });

      return containers;
    } else {
      containers.add(Container(
        child: Text("NoComments"),
      ));
      return containers;
    }
  }
}
