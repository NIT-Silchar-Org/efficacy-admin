import 'package:json_annotation/json_annotation.dart';

part 'developer_model.g.dart';

@JsonSerializable()
class Developer {
  String name, position, branch, imgUrl, fbUrl, linkedInUrl;
  Developer(
      {required this.name,
      required this.position,
      required this.branch,
      required this.fbUrl,
      required this.imgUrl,
      required this.linkedInUrl});
  factory Developer.fromJson(Map<String, dynamic> json) =>
      _$DeveloperFromJson(json);

  Map<String, dynamic> toJson() => _$DeveloperToJson(this);
}
