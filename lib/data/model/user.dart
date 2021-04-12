class User {
  String address;
  String url_avt;
  double birthday;
  String centerCode;
  String classCode;
  String districtID;
  String email;
  String fullName;
  String id;
  String imageName;
  String imageType;
  String phoneNo;
  String positionCode;
  String provinceCode;
  String roleID;
  String roleName;
  String userName;

  User(
      this.address,
      this.url_avt,
      this.birthday,
      this.centerCode,
      this.classCode,
      this.districtID,
      this.email,
      this.fullName,
      this.id,
      this.imageName,
      this.imageType,
      this.phoneNo,
      this.positionCode,
      this.provinceCode,
      this.roleID,
      this.roleName,
      this.userName);
  static User fromJson(Map<String, dynamic> json) {
    var results = json['data']['userInfo'];
    User user = new User(
      results['address'] == null ? "" : results['address'] as String,
      results['url_avt'] == null ? "" : results['url_avt'] as String,
      results['birthday'] == null ? 0.0 : results['birthday'] as double,
      results['centerCode'] == null ? "" : results['centerCode'] as String,
      results['classCode'] == null ? "" : results['classCode'] as String,
      results['districtID'] == null ? "" : results['districtID'] as String,
      results['email'] == null ? "" : results['email'] as String,
      results['fullName'] == null ? "" : results['fullName'] as String,
      results['id'] == null ? null : results['id'] as String,
      results['imageName'] == null ? "" : results['imageName'] as String,
      results['imageType'] == null ? "" : results['imageType'] as String,
      results['phoneNo'] == null ? "" : results['phoneNo'] as String,
      results['positionCode'] == null ? "" : results['positionCode'] as String,
      results['provinceCode'] == null ? "" : results['provinceCode'] as String,
      results['roleID'] == null ? "" : results['roleID'] as String,
      results['roleName'] == null ? "" : results['roleName'] as String,
      results['userName'] == null ? "" : results['userName'] as String,
    );

    return user;
  }
}
