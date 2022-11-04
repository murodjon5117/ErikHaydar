class CitiesModel {
  List<Regions>? regions;

  CitiesModel({this.regions});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  int? id;
  String? nameUz;
  String? nameOz;
  String? nameRu;

  Regions({this.id, this.nameUz, this.nameOz, this.nameRu});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
    nameOz = json['name_oz'];
    nameRu = json['name_ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_uz'] = nameUz;
    data['name_oz'] = nameOz;
    data['name_ru'] = nameRu;
    return data;
  }
}
