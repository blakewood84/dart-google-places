import 'dart:convert' show jsonDecode;

import 'package:dio/dio.dart';
import 'package:google_places_details/src/models/details.dart';
import 'package:google_places_details/src/models/interface.dart';

/// {@template google_places_details}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class GooglePlacesDetails implements IGooglePlacesDetails {
  /// {@macro google_places_details}
  const GooglePlacesDetails({
    required String apiKey,
  }) : _apiKey = apiKey;

  final String _apiKey;

  @override
  Future<Details> getDetails(String placeId) async {
    final uri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: '/maps/api/place/details/json',
      queryParameters: {
        'fields': 'address_components',
        'place_id': placeId,
        'key': _apiKey,
      },
    );

    final response = await Dio().get<String>(
      uri.toString(),
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    final result = jsonDecode(response.data ?? '') as Map<String, dynamic>;
    final addressComponents = ((result['result'] as Map<String, dynamic>?) //
            ?['address_components'] as List<dynamic>?)
        ?.cast<Map<String, dynamic>>();

    final streetNumber = addressComponents?.firstWhere(
      (e) => (e['types'] as List<String>?)?.contains('street_number') ?? false,
      orElse: () => {
        'short_name': '-Unknown-',
      },
    )['short_name'] as String?;

    final route = addressComponents?.firstWhere(
      (e) => (e['types'] as List<String>?)?.contains('route') ?? false,
      orElse: () => {
        'short_name': '-Unknown-',
      },
    )['short_name'] as String?;

    final city = addressComponents?.firstWhere(
      (e) => (e['types'] as List<String>?)?.contains('locality') ?? false,
      orElse: () => {
        'long_name': '-Unknown-',
      },
    )['long_name'] as String?;

    final state = addressComponents?.firstWhere(
      (e) =>
          (e['types'] as List<String>?)?.contains(
            'administrative_area_level_1',
          ) ??
          false,
      orElse: () => {
        'long_name': '-Unknown-',
      },
    )['long_name'] as String?;

    final zip = addressComponents?.firstWhere(
      (e) => (e['types'] as List<String>?)?.contains('postal_code') ?? false,
      orElse: () => {
        'long_name': '-Unknown-',
      },
    )['long_name'] as String?;

    final country = addressComponents?.firstWhere(
      (e) => (e['types'] as List<String>?)?.contains('country') ?? false,
      orElse: () => {
        'long_name': '-Unknown-',
      },
    )['long_name'] as String?;

    return Details(
      street: '$streetNumber $route',
      state: state ?? '-Unknown-',
      city: city ?? '-Unknown-',
      zip: zip ?? '-Unknown-',
      country: country ?? '-Unknown-',
    );
  }
}
