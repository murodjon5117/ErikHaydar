class SliderModel {
  int? id;
  String? title;
  String? url;
  Film? film;

  SliderModel({this.id, this.title, this.url, this.film});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    film = json['film'] != null ? Film.fromJson(json['film']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    if (film != null) {
      data['film'] = film!.toJson();
    }
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
  String? year;
  List<String>? genres;

  Film(
      {this.id,
      this.name,
      this.description,
      this.slug,
      this.likesCount,
      this.dislikesCount,
      this.image,
      this.year,
      this.genres});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
    image = json['image'];
    year = json['year'];
    if (json['genres'] != null) {
      genres = <String>[];
      json['genres'].forEach((v) {
        genres!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['slug'] = slug;
    data['likesCount'] = likesCount;
    data['dislikesCount'] = dislikesCount;
    data['image'] = image;
    data['year'] = year;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toString()).toList();
    }
    return data;
  }
}
