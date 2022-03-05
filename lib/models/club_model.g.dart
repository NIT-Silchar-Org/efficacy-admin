// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) => ClubModel(
      clubId: json['clubId'] as String,
      clubName: json['clubName'] as String,
      clubLogoURL: json['clubLogoURL'] as String,
      clubDescription: json['clubDescription'] as String,
      fbPageUrl: json['fbPageUrl'] as String,
      instagramUrl: json['instagramUrl'] as String,
      linkedlnURL: json['linkedlnURL'] as String,
      moderators: (json['moderators'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      followers:
          (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClubModelToJson(ClubModel instance) => <String, dynamic>{
      'clubId': instance.clubId,
      'clubName': instance.clubName,
      'clubLogoURL': instance.clubLogoURL,
      'clubDescription': instance.clubDescription,
      'fbPageUrl': instance.fbPageUrl,
      'instagramUrl': instance.instagramUrl,
      'linkedlnURL': instance.linkedlnURL,
      'moderators': instance.moderators.map((e) => e.toJson()).toList(),
      'followers': instance.followers,
    };
