// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEventModel _$AddEventModelFromJson(Map<String, dynamic> json) =>
    AddEventModel(
      eventName: json['eventName'] as String?,
      posterURL: json['posterURL'] as String?,
      shortDescription: json['shortDescription'] as String?,
      longDescription: json['longDescription'] as String?,
      clubId: json['clubId'] as String?,
      clubName: json['clubName'] as String?,
      clubLogoURL: json['clubLogoURL'] as String?,
      fbPostUrl: json['fbPostUrl'] as String?,
      googleFormURL: json['googleFormURL'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      venue: json['venue'] as String?,
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddEventModelToJson(AddEventModel instance) =>
    <String, dynamic>{
      'eventName': instance.eventName,
      'posterURL': instance.posterURL,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'clubId': instance.clubId,
      'clubName': instance.clubName,
      'clubLogoURL': instance.clubLogoURL,
      'fbPostUrl': instance.fbPostUrl,
      'googleFormURL': instance.googleFormURL,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'venue': instance.venue,
      'contacts': instance.contacts?.map((e) => e.toJson()).toList(),
    };
