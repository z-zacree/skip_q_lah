import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skip_q_lah/models/constants.dart';

part 'news.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class News {
  final String title, content, displayImage;
  final List<String> categories;
  final DateTime uploadedAt;

  const News({
    required this.title,
    required this.content,
    required this.displayImage,
    required this.categories,
    required this.uploadedAt,
  });

  factory News.fromJson(JsonResponse json) => _$NewsFromJson(json);

  factory News.fromFire(JsonResponse json) {
    json.update(
      'uploaded_at',
      (value) => (json['uploaded_at'] as Timestamp).toDate().toString(),
    );
    return News.fromJson(json);
  }

  JsonResponse toJson() => _$NewsToJson(this);
}
