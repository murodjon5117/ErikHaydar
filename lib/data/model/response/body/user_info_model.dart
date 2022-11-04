class UserInfoData {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  int? status;
  String? img;
  String? genderName;
  String? regionId;
  String? bornDate;
  String? authKey;
  int? allowedDevicesCount;

  UserInfoData(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.status,
      this.img,
      this.genderName,
      this.regionId,
      this.bornDate,
      this.authKey,
      this.allowedDevicesCount});

  UserInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    status = json['status'];
    img = json['img'];
    genderName = json['genderName'];
    regionId = json['region_id'];
    bornDate = json['born_date'];
    authKey = json['auth_key'];
    allowedDevicesCount = json['allowed_devices_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['status'] = status;
    data['img'] = img;
    data['genderName'] = genderName;
    data['region_id'] = regionId;
    data['born_date'] = bornDate;
    data['auth_key'] = authKey;
    data['allowed_devices_count'] = allowedDevicesCount;
    return data;
  }
}
