// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Developer _$DeveloperFromJson(Map<String, dynamic> json) => Developer(
      name: json['name'] as String,
      position: json['position'] as String,
      branch: json['branch'] as String,
      fbUrl: json['fbUrl'] as String,
      imgUrl: json['imgUrl'] as String,
      linkedInUrl: json['linkedInUrl'] as String,
    );

Map<String, dynamic> _$DeveloperToJson(Developer instance) => <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'branch': instance.branch,
      'imgUrl': instance.imgUrl,
      'fbUrl': instance.fbUrl,
      'linkedInUrl': instance.linkedInUrl,
    };
