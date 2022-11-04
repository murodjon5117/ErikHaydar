class MusicModel {
  int? id;
  String? name;
  String? musicAuthor;
  String? description;
  String? slug;
  int? likesCount;
  int? dislikesCount;
  int? activeCommentsCount;
  int? viewsCount;
  String? image;
  bool? isUserFavoriteFilm;
  bool? isFree;

  MusicModel(
      {this.id,
      this.name,
      this.musicAuthor,
      this.description,
      this.slug,
      this.likesCount,
      this.dislikesCount,
      this.activeCommentsCount,
      this.viewsCount,
      this.image,
      this.isUserFavoriteFilm,
      this.isFree});

  MusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    musicAuthor = json['music_author'];
    description = json['description'];
    slug = json['slug'];
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
    activeCommentsCount = json['activeCommentsCount'];
    viewsCount = json['viewsCount'];
    image = json['image'];
    isUserFavoriteFilm = json['isUserFavoriteFilm'];
    isFree = json['isFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['music_author'] = musicAuthor;
    data['description'] = description;
    data['slug'] = slug;
    data['likesCount'] = likesCount;
    data['dislikesCount'] = dislikesCount;
    data['activeCommentsCount'] = activeCommentsCount;
    data['viewsCount'] = viewsCount;
    data['image'] = image;
    data['isUserFavoriteFilm'] = isUserFavoriteFilm;
    data['isFree'] = isFree;
    return data;
  }
}
