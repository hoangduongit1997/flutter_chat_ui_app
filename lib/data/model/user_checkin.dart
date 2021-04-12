class UserCheckin {
  double Checkin_Time;
  String FullName;
  String UserID;
  String avD;
  String avType;
  int eventID;
  String url_avt;
  UserCheckin(this.Checkin_Time, this.FullName, this.UserID, this.avD,
      this.avType, this.eventID, this.url_avt);

  static List<UserCheckin> fromJson(Map<String, dynamic> json) {
    List<UserCheckin> rs = [];
    var results = json['data']['EnvCkList'] as List;
    for (var item in results) {
      var event = new UserCheckin(
          item['Checkin_Time'] == null ? null : item['Checkin_Time'] as double,
          item['FullName'] == null ? null : item['FullName'] as String,
          item['UserID'] == null ? null : item['UserID'] as String,
          item['avD'] == null ? null : item['avD'] as String,
          item['avType'] == null ? null : item['avType'] as String,
          item['eventID'] == null ? null : item['eventID'] as int,
          item['url_avt'] == null ? null : item['url_avt'] as String);
      rs.add(event);
    }

    return rs;
  }
}
