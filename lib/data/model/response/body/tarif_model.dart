class TarifModel {
  int? id;
  String? name;
  List<String>? description;
  String? price;
  String? durationName;
  num? recommendStatus;
  bool? activeTariffStatus;
  String? expiredAt;

  TarifModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.durationName,
      this.recommendStatus,
      this.activeTariffStatus,
      this.expiredAt});

  TarifModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'].cast<String>();
    price = json['price'];
    durationName = json['durationName'];
    recommendStatus = json['recommend_status'];
    activeTariffStatus = json['activeTariffStatus'];
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['durationName'] = durationName;
    data['recommend_status'] = recommendStatus;
    data['activeTariffStatus'] = activeTariffStatus;
    data['expired_at'] = expiredAt;
    return data;
  }
}
