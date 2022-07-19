import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserData {
  final String uid, username, fullName, mobileNumber;
  final bool isAnon;

  const UserData({
    required this.uid,
    required this.isAnon,
    required this.fullName,
    required this.mobileNumber,
    required this.username,
  });

  factory UserData.fromJson(JsonResponse json) => _$UserDataFromJson(json);

  factory UserData.fromFire(String uid, bool isAnon, JsonResponse json) {
    json['uid'] = uid;
    json['is_anon'] = isAnon;

    return UserData.fromJson(json);
  }

  JsonResponse toJson() => _$UserDataToJson(this);
}
