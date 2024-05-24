import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class UserModal extends Equatable {
  const UserModal({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
    this.image,
  });

  factory UserModal.fromJson(String str) =>
      UserModal.fromMap(json.decode(str) as Map<String, dynamic>);

  factory UserModal.fromMap(Map<String, dynamic> json) => UserModal(
        id: json['id'] as int?,
        name: json['name'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        address: json['address'] == null
            ? null
            : Address.fromMap(json['address'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        website: json['website'] as String?,
        image: json['image'] as XFile?,
        company: json['company'] == null
            ? null
            : Company.fromMap(json['company'] as Map<String, dynamic>),
      );
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;
  final XFile? image;

  UserModal copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
    XFile? image,
  }) =>
      UserModal(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
        image: image ?? this.image,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address?.toMap(),
        'phone': phone,
        'website': website,
        'company': company?.toMap(),
        'image': image,
      };

  @override
  List<Object?> get props =>
      [id, name, username, email, address, phone, website, company, image];
}

class Address extends Equatable {
  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(String str) =>
      Address.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        street: json['street'] as String?,
        suite: json['suite'] as String?,
        city: json['city'] as String?,
        zipcode: json['zipcode'] as String?,
        geo: json['geo'] == null
            ? null
            : Geo.fromMap(json['geo'] as Map<String, dynamic>),
      );
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) =>
      Address(
        street: street ?? this.street,
        suite: suite ?? this.suite,
        city: city ?? this.city,
        zipcode: zipcode ?? this.zipcode,
        geo: geo ?? this.geo,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo?.toMap(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [street, suite, city, zipcode, geo];
}

class Geo extends Equatable {
  const Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(String str) =>
      Geo.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Geo.fromMap(Map<String, dynamic> json) => Geo(
        lat: json['lat'] as String?,
        lng: json['lng'] as String?,
      );
  final String? lat;
  final String? lng;

  Geo copyWith({
    String? lat,
    String? lng,
  }) =>
      Geo(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'lat': lat,
        'lng': lng,
      };

  @override
  List<Object?> get props => [lat, lng];
}

class Company extends Equatable {
  const Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(String str) =>
      Company.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        name: json['name'] as String?,
        catchPhrase: json['catchPhrase'] as String?,
        bs: json['bs'] as String?,
      );
  final String? name;
  final String? catchPhrase;
  final String? bs;

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) =>
      Company(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        bs: bs ?? this.bs,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'catchPhrase': catchPhrase,
        'bs': bs,
      };

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}
