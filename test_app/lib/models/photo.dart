import 'dart:convert';

class Photo {
    int albumId;
    int id;
    String title;
    String url;
    String thumbnailUrl;

    Photo({
        this.albumId,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
    });

    factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        albumId: json["albumId"] == null ? null : json["albumId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
    );

    Map<String, dynamic> toMap() => {
        "albumId": albumId == null ? null : albumId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    };
}