// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      scholarId: json['scholarId'] as String?,
      position: json['position'] as String?,
      branch: json['branch'] as String?,
      clubId: json['clubId'] as String?,
      clubName: json['clubName'] as String?,
      clubPhotoUrl: json['clubPhotoUrl'] as String?,
      userPhotoUrl: json['userPhotoUrl'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'scholarId': instance.scholarId,
      'position': instance.position,
      'branch': instance.branch,
      'clubId': instance.clubId,
      'clubName': instance.clubName,
      'clubPhotoUrl': instance.clubPhotoUrl,
      'userPhotoUrl': instance.userPhotoUrl,
    };
