import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/api/api.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/models/photo.dart';
import 'package:test_app/pages/photo.dart';
import 'package:test_app/views/settings_button.dart';
import '../custom_drawer.dart';

class AlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
          title: Text('Albums'),
          actions: <Widget>[
            SettingsButton(),
          ],
        ),
      body: FutureBuilder<Map<Album, List<Photo>>>(
        future: ApiRequests().getAlbumsWithPhotos(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<Album, List<Photo>>> snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              children: viewAlbums(snapshot, context),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  List<InkWell> viewAlbums(AsyncSnapshot snapshot, BuildContext context) {
    Map<Album, List<Photo>> map = snapshot.data;
    List<InkWell> containers = [];
    map.forEach((Album album, List<Photo> photos) {
      containers.add(InkWell(
        onTap: () {
          navigate(context, photos);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          height: 500,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Album: " + album.id.toString(),
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(0),
                    child: CachedNetworkImage(
                      imageUrl: photos.first.url,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    )),
              ),
            ],
          ),
        ),
      ));
    });

    return containers;
  }

  void navigate(BuildContext context, List<Photo> photos) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoPage(
              photos: photos,
            ),
      ),
    );
  }
}
