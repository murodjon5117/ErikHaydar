class TarifModel {
  int? id;
  int? isPremium;
  String? name;
  bool? activeTariffStatus;
  List<ActiveItems>? activeItems;

  TarifModel(
      {this.id,
      this.isPremium,
      this.name,
      this.activeTariffStatus,
      this.activeItems});

  TarifModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPremium = json['is_premium'];
    name = json['name'];
    activeTariffStatus = json['activeTariffStatus'];
    if (json['activeItems'] != null) {
      activeItems = <ActiveItems>[];
      json['activeItems'].forEach((v) {
        activeItems!.add(ActiveItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_premium'] = isPremium;
    data['name'] = name;
    data['activeTariffStatus'] = activeTariffStatus;
    if (activeItems != null) {
      data['activeItems'] = activeItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActiveItems {
  int? id;
  String? name;
  String? price;
  String? durationName;
  bool? activeTariffStatus;
  String? expiredAt;

  ActiveItems(
      {this.id,
      this.name,
      this.price,
      this.durationName,
      this.activeTariffStatus,
      this.expiredAt});

  ActiveItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    durationName = json['durationName'];
    activeTariffStatus = json['activeTariffStatus'];
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['durationName'] = durationName;
    data['activeTariffStatus'] = activeTariffStatus;
    data['expired_at'] = expiredAt;
    return data;
  }
}
