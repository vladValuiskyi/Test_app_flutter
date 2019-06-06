import 'dart:convert';

class Geo {
    String lat;
    String lng;

    Geo({
        this.lat,
        this.lng,
    });

    factory Geo.fromJson(String str) => Geo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geo.fromMap(Map<String, dynamic> json) => Geo(
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
    );

    Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
    };
}
