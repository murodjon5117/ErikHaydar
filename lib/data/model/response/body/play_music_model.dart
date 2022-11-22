class PlayMusicModel {
  int? id;
  String? name;
  String? slug;
  bool? isFree;
  String? sources;

  PlayMusicModel({this.id, this.name, this.slug, this.isFree, this.sources});

  PlayMusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    isFree = json['isFree'];
    sources = json['sources'];
  }

}
