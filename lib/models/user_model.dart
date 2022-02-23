import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name,
      userId,
      email,
      phoneNumber,
      scholarId,
      post,
      branch,
      clubId,
      clubName,
      clubPhotoUrl;
  UserModel(
      {required this.name,
      required this.userId,
      required this.email,
      required this.phoneNumber,
      required this.clubName,
      this.scholarId,
      this.post,
      this.branch,
      this.clubId,
      this.clubPhotoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
