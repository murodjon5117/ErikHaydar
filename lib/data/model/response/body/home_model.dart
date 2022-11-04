class HomeModel {
  int? id;
  String? slug;
  String? name;
  List<Films>? films;

  HomeModel({this.id, this.slug, this.name, this.films});

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    if (json['films'] != null) {
      films = <Films>[];
      json['films'].forEach((v) {
        films!.add(Films.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    if (films != null) {
      data['films'] = films!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Films {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? activeCommentsCount;
  String? image;
  int? viewsCount;
  bool? isFree;
  String? qualityText;
  bool? isUserFavoriteFilm;

  Films(
      {this.id,
      this.name,
      this.description,
      this.slug,
      this.activeCommentsCount,
      this.image,
      this.viewsCount,
      this.isFree,
      this.qualityText,
      this.isUserFavoriteFilm});

  Films.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    activeCommentsCount = json['activeCommentsCount'];
    image = json['image'];
    viewsCount = json['viewsCount'];
    isFree = json['isFree'];
    qualityText = json['qualityText'];
    isUserFavoriteFilm = json['isUserFavoriteFilm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['slug'] = slug;
    data['activeCommentsCount'] = activeCommentsCount;
    data['image'] = image;
    data['viewsCount'] = viewsCount;
    data['isFree'] = isFree;
    data['qualityText'] = qualityText;
    data['isUserFavoriteFilm'] = isUserFavoriteFilm;
    return data;
  }
}
