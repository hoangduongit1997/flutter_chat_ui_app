import 'dart:convert';

class EventDetailedOutModel {
  int code;
  Data data;
  List<Message> message;
  bool success;

  EventDetailedOutModel({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  factory EventDetailedOutModel.fromRawJson(String str) =>
      EventDetailedOutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventDetailedOutModel.fromJson(Map<String, dynamic> json) =>
      EventDetailedOutModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null
            ? null
            : List<Message>.from(
                json["message"].map((x) => Message.fromJson(x))),
        success: json["success"] == null ? null : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null
            ? null
            : List<dynamic>.from(message.map((x) => x.toJson())),
        "success": success == null ? null : success,
      };
}

class Data {
  List<Events> eventDetail;

  Data({
    this.eventDetail,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        eventDetail: json["events"] == null
            ? null
            : List<Events>.from(json["events"].map((x) => Events.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": eventDetail == null
            ? null
            : List<dynamic>.from(eventDetail.map((x) => x.toJson())),
      };
}

class Events {
  String address;
  String cUserId;
  String centerCode;
  int commentlockFlag;
  int districtId;
  String eventDetail;
  int eventId;
  double fromTime;
  String inputtedTime;
  bool isPublic;
  double perRate;
  String provinceCode;
  double ratting;
  String shortDetail;
  String status;
  int statusCode;
  String title;
  double toTime;
  int totalComment;
  int totalPersonRate;
  int type;
  String urlAvt;
  String urlImgEnv;

  Events({
    this.address,
    this.cUserId,
    this.centerCode,
    this.commentlockFlag,
    this.districtId,
    this.eventDetail,
    this.eventId,
    this.fromTime,
    this.inputtedTime,
    this.isPublic,
    this.perRate,
    this.provinceCode,
    this.ratting,
    this.shortDetail,
    this.status,
    this.statusCode,
    this.title,
    this.toTime,
    this.totalComment,
    this.totalPersonRate,
    this.type,
    this.urlAvt,
    this.urlImgEnv,
  });

  factory Events.fromRawJson(String str) => Events.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        address: json["address"] == null ? null : json["address"],
        cUserId: json["cUserId"] == null ? null : json["cUserId"],
        centerCode: json["centerCode"] == null ? null : json["centerCode"],
        commentlockFlag:
            json["commentlockFlag"] == null ? null : json["commentlockFlag"],
        districtId: json["districtID"] == null ? null : json["districtID"],
        eventDetail: json["eventDetail"] == null ? null : json["eventDetail"],
        eventId: json["eventID"] == null ? null : json["eventID"],
        fromTime: json["fromTime"] == null ? null : json["fromTime"].toDouble(),
        inputtedTime:
            json["inputtedTime"] == null ? null : json["inputtedTime"],
        isPublic: json["isPublic"] == null ? null : json["isPublic"],
        perRate: json["perRate"] == null ? null : json["perRate"].toDouble(),
        provinceCode:
            json["provinceCode"] == null ? null : json["provinceCode"],
        ratting: json["ratting"] == null ? null : json["ratting"].toDouble(),
        shortDetail: json["shortDetail"] == null ? null : json["shortDetail"],
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        title: json["title"] == null ? null : json["title"],
        toTime: json["toTime"] == null ? null : json["toTime"].toDouble(),
        totalComment:
            json["totalComment"] == null ? null : json["totalComment"],
        totalPersonRate:
            json["totalPersonRate"] == null ? null : json["totalPersonRate"],
        type: json["type"] == null ? null : json["type"],
        urlAvt: json["url_avt"] == null ? null : json["url_avt"],
        urlImgEnv: json["url_imgEnv"] == null ? null : json["url_imgEnv"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "cUserId": cUserId == null ? null : cUserId,
        "centerCode": centerCode == null ? null : centerCode,
        "commentlockFlag": commentlockFlag == null ? null : commentlockFlag,
        "districtID": districtId == null ? null : districtId,
        "eventDetail": eventDetail == null ? null : eventDetail,
        "eventID": eventId == null ? null : eventId,
        "fromTime": fromTime == null ? null : fromTime,
        "inputtedTime": inputtedTime == null ? null : inputtedTime,
        "isPublic": isPublic == null ? null : isPublic,
        "perRate": perRate == null ? null : perRate,
        "provinceCode": provinceCode == null ? null : provinceCode,
        "ratting": ratting == null ? null : ratting,
        "shortDetail": shortDetail == null ? null : shortDetail,
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "title": title == null ? null : title,
        "toTime": toTime == null ? null : toTime,
        "totalComment": totalComment == null ? null : totalComment,
        "totalPersonRate": totalPersonRate == null ? null : totalPersonRate,
        "type": type == null ? null : type,
        "url_avt": urlAvt == null ? null : urlAvt,
        "url_imgEnv": urlImgEnv == null ? null : urlImgEnv,
      };
}

class Message {
  int code;
  String message;

  Message({
    this.code,
    this.message,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}
