import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name,
      userId,
      email,
      phoneNumber,
      scholarId,
      position,
      branch,
      clubId,
      clubName,
      clubPhotoUrl,
      userPhotoUrl;
  UserModel({
    this.name,
    this.userId,
    this.email,
    this.phoneNumber,
    this.scholarId,
    this.position,
    this.branch,
    this.clubId,
    this.clubName,
    this.clubPhotoUrl,
    this.userPhotoUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
