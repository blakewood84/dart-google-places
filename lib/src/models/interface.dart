import 'package:google_places_details/src/models/details.dart';

/// Interface for GooglePlacesDetails
abstract class IGooglePlacesDetails {
  const IGooglePlacesDetails._();

  /// Fetches details of any [placeId] and returns the [Details] class.
  Future<Details> getDetails(String placeId);
}
