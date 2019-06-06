import 'dart:convert';

class Album {
    int userId;
    int id;
    String title;

    Album({
        this.userId,
        this.id,
        this.title,
    });

    factory Album.fromJson(String str) => Album.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Album.fromMap(Map<String, dynamic> json) => Album(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toMap() => {
        "userId": userId == null ? null : userId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
    };
}
