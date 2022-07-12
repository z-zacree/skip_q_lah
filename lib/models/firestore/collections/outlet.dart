import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';

part 'outlet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@LatLngSerializer()
class Outlet {
  final String id, name, contactNumber, displayImage, description;
  final bool isOpen;
  final List<Period> openingHours;
  final Address address;
  final LatLng latLng;

  const Outlet({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.displayImage,
    required this.description,
    required this.isOpen,
    required this.openingHours,
    required this.address,
    required this.latLng,
  });

  factory Outlet.fromJson(JsonResponse json) {
    return _$OutletFromJson(json);
  }

  factory Outlet.fromFire(
    String id,
    JsonResponse latLng,
    JsonResponse json,
  ) {
    json['id'] = id;
    json['lat_lng'] = latLng;
    return Outlet.fromJson(json);
  }

  JsonResponse toJson() => _$OutletToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Period {
  final Timing open, close;

  Period({required this.open, required this.close});

  factory Period.fromJson(JsonResponse json) => _$PeriodFromJson(json);
  JsonResponse toJson() => _$PeriodToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Timing {
  final int day;
  final String time;

  Timing({required this.day, required this.time});

  factory Timing.fromJson(JsonResponse json) => _$TimingFromJson(json);
  JsonResponse toJson() => _$TimingToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Address {
  final String full, main, sub, postalCode, placeId;

  Address({
    required this.full,
    required this.main,
    required this.sub,
    required this.placeId,
    required this.postalCode,
  });

  factory Address.fromJson(JsonResponse json) => _$AddressFromJson(json);
  JsonResponse toJson() => _$AddressToJson(this);
}
