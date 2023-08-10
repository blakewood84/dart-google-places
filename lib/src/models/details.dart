// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:meta/meta.dart' show immutable;

@immutable
class Details {
  const Details({
    required this.street,
    required this.state,
    required this.city,
    required this.zip,
    required this.country,
  });

  final String street;
  final String state;
  final String city;
  final String zip;
  final String country;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'state': state,
      'city': city,
      'zip': zip,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Details(street: $street, state: $state, city: $city, zip: $zip)';
  }

  @override
  bool operator ==(covariant Details other) {
    if (identical(this, other)) return true;
  
    return 
      other.street == street &&
      other.state == state &&
      other.city == city &&
      other.zip == zip;
  }

  @override
  int get hashCode {
    return street.hashCode ^
      state.hashCode ^
      city.hashCode ^
      zip.hashCode;
  }
}
