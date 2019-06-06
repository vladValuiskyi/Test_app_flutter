import 'dart:convert';

import './geo.dart';

class Address {
    String street;
    String suite;
    String city;
    String zipcode;
    Geo geo;

    Address({
        this.street,
        this.suite,
        this.city,
        this.zipcode,
        this.geo,
    });

    factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Address.fromMap(Map<String, dynamic> json) => Address(
        street: json["street"] == null ? null : json["street"],
        suite: json["suite"] == null ? null : json["suite"],
        city: json["city"] == null ? null : json["city"],
        zipcode: json["zipcode"] == null ? null : json["zipcode"],
        geo: json["geo"] == null ? null : Geo.fromMap(json["geo"]),
    );

    Map<String, dynamic> toMap() => {
        "street": street == null ? null : street,
        "suite": suite == null ? null : suite,
        "city": city == null ? null : city,
        "zipcode": zipcode == null ? null : zipcode,
        "geo": geo == null ? null : geo.toMap(),
    };
}
