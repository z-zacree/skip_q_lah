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
      isOpen: json['is_open'] as bool,
      openingHours: (json['opening_hours'] as List<dynamic>)
          .map((e) =>
              const PeriodSerializer().fromJson(e as Map<String, dynamic>))
          .toList(),
      location: const LatLngSerializer()
          .fromJson(json['location'] as Map<String, dynamic>),
      address: json['address'] as String,
      eatingInType: $enumDecode(_$ServiceTypeEnumMap, json['eating_in_type']),
      takeawayType: $enumDecode(_$ServiceTypeEnumMap, json['takeaway_type']),
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contact_number': instance.contactNumber,
      'display_image': instance.displayImage,
      'description': instance.description,
      'address': instance.address,
      'is_open': instance.isOpen,
      'opening_hours':
          instance.openingHours.map(const PeriodSerializer().toJson).toList(),
      'takeaway_type': _$ServiceTypeEnumMap[instance.takeawayType],
      'eating_in_type': _$ServiceTypeEnumMap[instance.eatingInType],
      'location': const LatLngSerializer().toJson(instance.location),
    };

const _$ServiceTypeEnumMap = {
  ServiceType.notAvailable: 'not_available',
  ServiceType.pickup: 'pickup',
  ServiceType.tableDelivery: 'table_delivery',
};

Period _$PeriodFromJson(Map<String, dynamic> json) => Period(
      isOpen: json['is_open'] as bool? ?? true,
      open: DateTime.parse(json['open'] as String),
      close: DateTime.parse(json['close'] as String),
    );

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
      'is_open': instance.isOpen,
      'open': instance.open.toIso8601String(),
      'close': instance.close.toIso8601String(),
    };
