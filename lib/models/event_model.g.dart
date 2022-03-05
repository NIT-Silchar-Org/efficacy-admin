// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      usersWhoLiked: (json['usersWhoLiked'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      eventId: json['eventId'] as String?,
      posterURL: json['posterURL'] as String?,
      shortDescription: json['shortDescription'] as String?,
      longDescription: json['longDescription'] as String?,
      eventName: json['eventName'] as String?,
      clubId: json['clubId'] as String?,
      clubName: json['clubName'] as String?,
      clubLogoURL: json['clubLogoURL'] as String?,
      fbPostUrl: json['fbPostUrl'] as String?,
      googleFormURL: json['googleFormURL'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      venue: json['venue'] as String?,
      contact: (json['contact'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'usersWhoLiked': instance.usersWhoLiked,
      'contact': instance.contact?.map((e) => e.toJson()).toList(),
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'eventName': instance.eventName,
      'eventId': instance.eventId,
      'posterURL': instance.posterURL,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'clubId': instance.clubId,
      'clubName': instance.clubName,
      'clubLogoURL': instance.clubLogoURL,
      'fbPostUrl': instance.fbPostUrl,
      'googleFormURL': instance.googleFormURL,
      'venue': instance.venue,
    };
