import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';

part 'outlet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@LatLngSerializer()
class Outlet {
  final String id, name, contactNumber, displayImage, description;

  final List<Period> openingHours;
  final Address address;
  final LatLng latLng;

  Outlet({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.displayImage,
    required this.description,
    required this.openingHours,
    required this.address,
    required this.latLng,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return _$OutletFromJson(json);
  }

  factory Outlet.fromFire(String id, LatLng latLng, Map<String, dynamic> json) {
    json['id'] = id;
    json['lat_lng'] = latLng;
    return Outlet.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$OutletToJson(this);

  bool isOpen() {
    DateTime currentDateTime = DateTime.now();

    int currentDay = currentDateTime.weekday;

    List<Period> checkPeriods = openingHours.where((Period period) {
      return period.open.day == currentDay || period.close.day == currentDay;
    }).toList();

    List<bool> checks = [];

    for (Period checkPeriod in checkPeriods) {
      DateTime openDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        checkPeriod.open.day == currentDay
            ? currentDateTime.day
            : currentDateTime.day - 1,
        int.parse(checkPeriod.open.time.substring(0, 2)),
        int.parse(checkPeriod.open.time.substring(2, 4)),
      );

      DateTime closeDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        checkPeriod.close.day == currentDay
            ? currentDateTime.day
            : currentDateTime.day + 1,
        int.parse(checkPeriod.close.time.substring(0, 2)),
        int.parse(checkPeriod.close.time.substring(2, 4)),
      );

      if (currentDateTime.compareTo(openDateTime) == 1 &&
          currentDateTime.compareTo(closeDateTime) == -1) {
        checks.add(true);
      } else {
        checks.add(false);
      }
    }

    return true;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Period {
  final Timing open, close;

  Period({required this.open, required this.close});

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Timing {
  final int day;
  final String time;

  Timing({required this.day, required this.time});

  factory Timing.fromJson(Map<String, dynamic> json) => _$TimingFromJson(json);
  Map<String, dynamic> toJson() => _$TimingToJson(this);
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

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
