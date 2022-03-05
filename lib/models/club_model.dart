import 'package:efficacy_admin/models/contacts_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'club_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ClubModel {
  String clubId,
      clubName,
      clubLogoURL,
      clubDescription,
      fbPageUrl,
      instagramUrl,
      linkedlnURL;
  List<Contact> moderators;
  List<String> followers;
  ClubModel(
      {required this.clubId,
      required this.clubName,
      required this.clubLogoURL,
      required this.clubDescription,
      required this.fbPageUrl,
      required this.instagramUrl,
      required this.linkedlnURL,
      required this.moderators,
      required this.followers});
    factory ClubModel.fromJson(Map<String, dynamic> json) => _$ClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubModelToJson(this);

}
