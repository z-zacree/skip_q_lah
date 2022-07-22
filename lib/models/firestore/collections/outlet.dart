import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/enums.dart';

part 'outlet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@LatLngSerializer()
@PeriodSerializer()
class Outlet {
  final String id, name, contactNumber, displayImage, description, address;
  final bool isOpen;
  final List<Period> openingHours;
  final ServiceType takeawayType, eatingInType;
  final LatLng location;

  const Outlet({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.displayImage,
    required this.description,
    required this.isOpen,
    required this.openingHours,
    required this.location,
    required this.address,
    required this.eatingInType,
    required this.takeawayType,
  });

  factory Outlet.fromJson(JsonResponse json) => _$OutletFromJson(json);

  factory Outlet.fromFire(
    JsonResponse dataPlus,
    JsonResponse json,
  ) {
    json['id'] = dataPlus['id'];
    json['location'] = dataPlus['location'];
    json['address'] = dataPlus['address'];

    json.remove('place_id');
    return _$OutletFromJson(json);
  }

  JsonResponse toJson() => _$OutletToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Period {
  final bool isOpen;
  final DateTime open, close;

  Period({
    this.isOpen = true,
    required this.open,
    required this.close,
  });

  factory Period.fromJson(JsonResponse json) {
    if (json['open'] == null) {
      return Period(
        isOpen: false,
        open: DateTime.now(),
        close: DateTime.now(),
      );
    }
    return _$PeriodFromJson(json);
  }
  JsonResponse toJson() => _$PeriodToJson(this);
}

class LatLngSerializer implements JsonConverter<LatLng, JsonResponse> {
  const LatLngSerializer();

  @override
  LatLng fromJson(JsonResponse json) => LatLng(
        json['latitude'],
        json['longitude'],
      );

  @override
  JsonResponse toJson(LatLng latLng) => <String, dynamic>{
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      };
}

class PeriodSerializer implements JsonConverter<Period, JsonResponse> {
  const PeriodSerializer();

  @override
  Period fromJson(JsonResponse json) {
    if (json['isOpen'] != null && json['isOpen'] == false) {
      return Period(
        isOpen: false,
        open: (json['open'] as Timestamp).toDate(),
        close: (json['close'] as Timestamp).toDate(),
      );
    } else {
      return Period(
        isOpen: true,
        open: (json['open'] as Timestamp).toDate(),
        close: (json['close'] as Timestamp).toDate(),
      );
    }
  }

  @override
  JsonResponse toJson(Period period) => <String, dynamic>{
        'open': Timestamp.fromDate(period.open),
        'close': Timestamp.fromDate(period.close),
        'isOpen': period.isOpen,
      };
}
