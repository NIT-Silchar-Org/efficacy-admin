import 'package:efficacy_admin/models/contacts_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventModel {
  EventModel({
    this.usersWhoLiked,
    this.eventId,
    this.posterURL,
    this.shortDescription,
    this.longDescription,
    this.eventName,
    this.clubId,
    this.clubName,
    this.clubLogoURL,
    this.fbPostUrl,
    this.googleFormURL,
    this.startTime,
    this.endTime,
    this.venue,
    this.contact,
    this.likesCount,
  });
  List<String>? usersWhoLiked;
  List<Contact>? contact;
  DateTime? startTime, endTime;
  String? eventName,
      eventId,
      posterURL,
      shortDescription,
      longDescription,
      clubId,
      clubName,
      clubLogoURL,
      fbPostUrl,
      googleFormURL,
      venue,
      likesCount;
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
