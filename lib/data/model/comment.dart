class Comment {
  String cUserID;
  String cUserName;
  String comment;
  double commentDate;
  int eventID;
  int id;
  String url;
  String urlFileName;
  bool urlIsImage;
  String url_avt;
  Comment(this.cUserID, this.cUserName, this.comment, this.commentDate,
      this.eventID, this.id, this.url,this.urlFileName,this.urlIsImage, this.url_avt);
  static List<Comment> fromJson(Map<String, dynamic> json) {
    List<Comment> rs = [];
    var results = json['data']['comments'] as List;
    for (var item in results) {
      var comment = new Comment(
        item['cUserID'] == null ? null : item['cUserID'] as String,
        item['cUserName'] == null ? null : item['cUserName'] as String,
        item['comment'] == null ? null : item['comment'] as String,
        item['commentDate'] == null ? null : item['commentDate'] as double,
        item['eventID'] == null ? null : item['eventID'] as int,
        item['id'] == null ? null : item['id'] as int,
        item['url'] == null ? null : item['url'] as String,
        item['urlFileName']==null?null:item['urlFileName'] as String,
        item['urlIsImage']==null?null:item['urlIsImage'] as bool,
        item['url_avt'] == null ? null : item['url_avt'] as String,
      );

      rs.add(comment);
    }

    return rs;
  }
}
