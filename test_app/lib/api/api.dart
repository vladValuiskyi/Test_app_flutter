import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/models/album.dart';
import 'package:test_app/models/comment.dart';
import 'package:test_app/models/photo.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/user.dart';

class ApiRequests {
  static final ApiRequests _instance = new ApiRequests._internal();

  factory ApiRequests() {
    return _instance;
  }
  ApiRequests._internal();

  Future<List<User>> getUsers() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/users');

    List<dynamic> rawList = json.decode(response.body);

    return rawList.map<User>((dynamic raw) {
      return User.fromMap(raw as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Post>> getPosts() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/posts');

    List<dynamic> rawList = json.decode(response.body);

    return rawList.map<Post>((dynamic raw) {
      return Post.fromMap(raw as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Comment>> getComments() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/comments');

    List<dynamic> rawList = json.decode(response.body);

    return rawList.map<Comment>((dynamic raw) {
      return Comment.fromMap(raw as Map<String, dynamic>);
    }).toList();
  }

  Future<Map<Post, List<Comment>>> getPostsWithComments() async {
    List<Post> posts = await getPosts();
    List<Comment> comments = await getComments();
    Map<Post, List<Comment>> map = {};

    for (Post post in posts) {
      map[post] = comments.where((Comment comment) {
        return comment.postId == post.id;
      }).toList();
    }

    return map;
  }

  Future<List<Album>> getAlbums() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/albums');

    List<dynamic> rawList = json.decode(response.body);

    return rawList.map<Album>((dynamic raw) {
      return Album.fromMap(raw as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Photo>> getPhotos() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/photos');

    List<dynamic> rawList = json.decode(response.body);

    return rawList.map<Photo>((dynamic raw) {
      return Photo.fromMap(raw as Map<String, dynamic>);
    }).toList();
  }

  Future<Map<Album, List<Photo>>> getAlbumsWithPhotos() async {
    List<Album> albums = await getAlbums();
    List<Photo> photos = await getPhotos();
    Map<Album, List<Photo>> map = {};

    for (Album album in albums) {
      map[album] = photos.where((Photo photo) {
        return photo.albumId == album.id;
      }).toList();
    }

    return map;
  }
}
