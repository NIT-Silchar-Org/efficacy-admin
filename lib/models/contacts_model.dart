import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';

@JsonSerializable()
class Contact {
  String name, phoneNumber, position;
  Contact({required this.name, required this.phoneNumber, required this.position});
    factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

}
