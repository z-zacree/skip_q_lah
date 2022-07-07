// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outlet _$OutletFromJson(Map<String, dynamic> json) => Outlet(
      id: json['id'] as String,
      name: json['name'] as String,
      contactNumber: json['contact_number'] as String,
      displayImage: json['display_image'] as String,
      description: json['description'] as String,
      openingHours: (json['opening_hours'] as List<dynamic>)
          .map((e) => Period.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      latLng: const LatLngSerializer().fromJson(json['lat_lng'] as LatLng),
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contact_number': instance.contactNumber,
      'display_image': instance.displayImage,
      'description': instance.description,
      'opening_hours': instance.openingHours.map((e) => e.toJson()).toList(),
      'address': instance.address.toJson(),
      'lat_lng': const LatLngSerializer().toJson(instance.latLng),
    };

Period _$PeriodFromJson(Map<String, dynamic> json) => Period(
      open: Timing.fromJson(json['open'] as Map<String, dynamic>),
      close: Timing.fromJson(json['close'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
      'open': instance.open.toJson(),
      'close': instance.close.toJson(),
    };

Timing _$TimingFromJson(Map<String, dynamic> json) => Timing(
      day: json['day'] as int,
      time: json['time'] as String,
    );

Map<String, dynamic> _$TimingToJson(Timing instance) => <String, dynamic>{
      'day': instance.day,
      'time': instance.time,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      full: json['full'] as String,
      main: json['main'] as String,
      sub: json['sub'] as String,
      placeId: json['place_id'] as String,
      postalCode: json['postal_code'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'full': instance.full,
      'main': instance.main,
      'sub': instance.sub,
      'postal_code': instance.postalCode,
      'place_id': instance.placeId,
    };
