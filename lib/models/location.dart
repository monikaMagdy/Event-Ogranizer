/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJosn(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Region {
  Region({
    this.coords,
    this.id,
    this.name,
    this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(josn);
  Map<String, dynamic> toJson() => _$RegionFromJson(this);

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Offices {
  Offices({
    this.address,
    this.id,
    this.image,
    this.lat,
    this.lng,
    this.name,
    this.phone,
    this.region,
  });

  factory Offices.fromJson(Map<String, dynamic> json) =>
      _$OfficesFromJson(josn);
  Map<String, dynamic> toJson() => _$OfficesFromJson(this);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({
    this.offices,
    this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsFromJson(this);

  final List<Offices> offices;
  final List<Region> regions;
}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = "https://about.google/static/data/locations.json";

  final response = await http.get(googleLocationsURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException("unexpected status",
        uri: Uri.parse(googleLocationsURL));
  }
}
*/
