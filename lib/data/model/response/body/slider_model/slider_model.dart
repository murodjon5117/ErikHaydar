class SliderModel {
  int? id;
  String? title;
  String? url;
  Film? film;
  String? link;

  SliderModel({this.id, this.title, this.url, this.film, this.link});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    film = json['film'] != null ? Film.fromJson(json['film']) : null;
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    if (film != null) {
      data['film'] = film!.toJson();
    }
    data['link'] = link;
    return data;
  }
}

class Film {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? likesCount;
  int? dislikesCount;
  String? image;
  bool? isFree;
  String? qualityText;
  int? isMusic;

  Film(
      {this.id,
      this.name,
      this.description,
      this.slug,
      this.likesCount,
      this.dislikesCount,
      this.image,
      this.isFree,
      this.qualityText,
      this.isMusic});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
    image = json['image'];
    isFree = json['isFree'];
    qualityText = json['qualityText'];
    isMusic = json['is_music'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['slug'] = slug;
    data['likesCount'] = likesCount;
    data['dislikesCount'] = dislikesCount;
    data['image'] = image;
    data['isFree'] = isFree;
    data['qualityText'] = qualityText;
    data['is_music'] = isMusic;
    return data;
  }
}
