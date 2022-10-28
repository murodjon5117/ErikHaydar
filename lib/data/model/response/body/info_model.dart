class UserInfoModelProfile {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? img;
  String? balance;
  String? activeTariff;
  Null? activeTariffId;
  String? expiredAt;
  String? status;
  int? noticeStatus;

  UserInfoModelProfile(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.img,
      this.balance,
      this.activeTariff,
      this.activeTariffId,
      this.expiredAt,
      this.status,
      this.noticeStatus});

  UserInfoModelProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    img = json['img'];
    balance = json['balance'];
    activeTariff = json['active_tariff'];
    activeTariffId = json['active_tariff_id'];
    expiredAt = json['expired_at'];
    status = json['status'];
    noticeStatus = json['notice_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['img'] = img;
    data['balance'] = balance;
    data['active_tariff'] = activeTariff;
    data['active_tariff_id'] = activeTariffId;
    data['expired_at'] = expiredAt;
    data['status'] = status;
    data['notice_status'] = noticeStatus;
    return data;
  }
}
