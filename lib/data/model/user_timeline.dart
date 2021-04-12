class UserInfoHistory {
  List<Activity> activity;
  int year;
  UserInfoHistory(this.activity, this.year);
  static List<UserInfoHistory> fromJson(Map<String, dynamic> json) {
    List<UserInfoHistory> rs = [];
    var results = json['data']['userInfoHistory'] as List;
    for (var item in results) {
      var event = new UserInfoHistory(
        item['activity'] == null
            ? null
            : List<Activity>.from(
                item["activity"].map((x) => Activity.fromJson(x))),
        item['year'] == null ? null : item['year'] as int,
      );

      rs.add(event);
    }
    return rs;
  }
}

class Activity {
  double checkinTime;
  String eventName;
  int id;
  String shortDetail;
  int type;
  dynamic urlImage;

  Activity({
    this.checkinTime,
    this.eventName,
    this.id,
    this.shortDetail,
    this.type,
    this.urlImage,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        checkinTime: json["checkinTime"] == null ? null : json["checkinTime"],
        eventName: json["eventName"] == null ? null : json["eventName"],
        id: json["id"] == null ? null : json["id"],
        shortDetail: json["shortDetail"] == null ? null : json["shortDetail"],
        type: json["type"] == null ? null : json["type"],
        urlImage: json["url_image"],
      );
}
