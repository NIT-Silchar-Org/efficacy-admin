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
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      venue: json['venue'] as String?,
      contact: (json['contact'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      likecount: json['likecount'] as int,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'usersWhoLiked': instance.usersWhoLiked,
      'contact': instance.contact?.map((e) => e.toJson()).toList(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'likecount': instance.likecount,
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
