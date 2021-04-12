import 'dart:convert';

class EventDetailedInModel {
  int eventId;
  String id;
  String authToken;

  EventDetailedInModel({
    this.eventId,
    this.id,
    this.authToken,
  });

  factory EventDetailedInModel.fromRawJson(String str) =>
      EventDetailedInModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventDetailedInModel.fromJson(Map<String, dynamic> json) =>
      EventDetailedInModel(
        eventId: json["eventID"] == null ? null : json["eventID"],
        id: json["id"] == null ? null : json["id"],
        authToken: json["auth_token"] == null ? null : json["auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "eventID": eventId == null ? null : eventId,
        "id": id == null ? null : id,
        "auth_token": authToken == null ? null : authToken,
      };
}
