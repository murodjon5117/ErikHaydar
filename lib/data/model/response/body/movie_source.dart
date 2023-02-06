class MovieSource {
  int? id;
  String? name;
  String? slug;
  String? qualityText;
  String? image;
  bool? isFree;
  int? year;
  String? sources;

  MovieSource(
      {this.id,
      this.name,
      this.slug,
      this.qualityText,
      this.image,
      this.isFree,
      this.year,
      this.sources});

  MovieSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    qualityText = json['qualityText'];
    image = json['image'];
    isFree = json['isFree'];
    year = json['year'];
    sources = json['sources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['qualityText'] = this.qualityText;
    data['image'] = this.image;
    data['isFree'] = this.isFree;
    data['year'] = this.year;
    data['sources'] = this.sources;
    return data;
  }
}
