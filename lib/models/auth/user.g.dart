// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      uid: json['uid'] as String,
      isAnon: json['is_anon'] as bool,
      fullName: json['full_name'] as String,
      mobileNumber: json['mobile_number'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'full_name': instance.fullName,
      'mobile_number': instance.mobileNumber,
      'is_anon': instance.isAnon,
    };
