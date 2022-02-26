import 'package:efficacy_admin/models/contact_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddEventModel {
  AddEventModel(
      {this.eventName,
      this.posterURL,
      this.shortDescription,
      this.longDescription,
      this.clubId,
      this.clubName,
      this.clubLogoURL,
      this.fbPostUrl,
      this.googleFormURL,
      this.startTime,
      this.endTime,
      this.venue,
      this.contacts});

  String? eventName,
      posterURL,
      shortDescription,
      longDescription,
      clubId,
      clubName,
      clubLogoURL,
      fbPostUrl,
      googleFormURL,
      startTime,
      endTime,
      venue;

  List<Contact>? contacts;

  factory AddEventModel.fromJson(Map<String, dynamic> json) =>
      _$AddEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddEventModelToJson(this);
}
