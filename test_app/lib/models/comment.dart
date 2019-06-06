import 'dart:convert';

class Comment {
    int postId;
    int id;
    String name;
    String email;
    String body;

    Comment({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body,
    });

    factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        postId: json["postId"] == null ? null : json["postId"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        body: json["body"] == null ? null : json["body"],
    );

    Map<String, dynamic> toMap() => {
        "postId": postId == null ? null : postId,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "body": body == null ? null : body,
    };
}