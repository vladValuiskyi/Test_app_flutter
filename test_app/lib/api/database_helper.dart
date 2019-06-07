import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/models/comment.dart';
import 'package:test_app/models/post.dart';

class DatabaseHelper {
  static final _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();

    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'test_app_db.db');
    //deleteDatabase(path);

    Database database =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database database, int newVersion) async {
    await database.execute(
        'Create table Posts(id Integer Primary Key, userId Integer, title Text, body Text)');
    await database.execute(
        'Create table Comments(id Integer Primary Key, postId Integer, name Text, email Text, body Text)');
  }

  Future close() async {
    Database dbClient = await database;
    return dbClient.close();
  }

  Future<int> savePost(Post post) async {
    Database dbClient = await database;
    if ((await getPost(post.id)).toString() == 'null') {
      int result = await dbClient.insert('Posts', post.toMap());
      return result;
    } else {
      return updatePost(post);
    }
  }

  Future<List<Post>> getAllPosts() async {
    Database dbClient = await database;
    List<Post> postResult = [];
    await dbClient.query('Posts',
        columns: ['id', 'userId', 'title', 'body']).then((var posts) {
      posts.forEach((var post) {
        Post newPost = Post.fromMap(post);
        postResult.add(newPost);
      });
    });
    return postResult;
  }

  Future<Post> getPost(int id) async {
    Database dbClient = await database;
    List<Map> result = await dbClient.query(
      'Posts',
      columns: ['id', 'userId', 'title', 'body'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.length > 0) {
      return Post.fromMap(result.first);
    }

    return null;
  }

  Future<int> deletePost(int id) async {
    Database dbClient = await database;
    return await dbClient.delete(
      'Posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePost(Post post) async {
    Database dbClient = await database;
    return await dbClient.update(
      'Posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  Future<int> saveComment(Comment comment) async {
    Database dbClient = await database;
    
    if ((await getComment(comment.id)).toString() == 'null') {
      int result = await dbClient.insert('Comments', comment.toMap());
      return result;
     } else {
       return updateComment(comment);
     }
  }

  Future<List<Comment>> getAllComments() async {
    Database dbClient = await database;
    List<Comment> commentResult = [];
    await dbClient.query('Comments',
        columns: ['id', 'postId', 'name', 'email', 'body']).then((var comments) {
      comments.forEach((var comment) {
        Comment newcomment = Comment.fromMap(comment);
        commentResult.add(newcomment);
      });
    });
    return commentResult;
  }
  Future<Comment> getComment(int id) async {
    Database dbClient = await database;
    List<Map> result = await dbClient.query(
      'Comments',
      columns: ['id', 'postId', 'name', 'email', 'body'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.length > 0) {
      return Comment.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteComment(int id) async {
    Database dbClient = await database;
    return await dbClient.delete(
      'Comments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateComment(Comment comment) async {
    Database dbClient = await database;
    return await dbClient.update(
      'Comments',
      comment.toMap(),
      where: 'id = ?',
      whereArgs: [comment.id],
    );
  }
}
