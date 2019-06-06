import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/photo.dart';
import 'package:test_app/views/settings_button.dart';

class PhotoPage extends StatefulWidget {
  final List<Photo> photos;

  const PhotoPage({Key key, this.photos}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState(photos);
}

class _PhotoPageState extends State<PhotoPage> {
  final List<Photo> _photos;

  _PhotoPageState(this._photos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Photos'),
        ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: _photos.map(
            (Photo photo) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.black45,
                      width: 2,
                    )),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                child: CachedNetworkImage(
                  imageUrl: photo.url,
                  placeholder: (context, url) => CircularProgressIndicator(),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
