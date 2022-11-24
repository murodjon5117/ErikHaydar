class DetailMusicMidel {
  int? id;
  String? slug;
  String? name;
  String? musicAuthor;
  String? image;
  bool? isFree;
  String? priceTypeName;
  String? type;
  int? likesCount;
  int? dislikesCount;
  bool? isLike;
  bool? isDisLike;
  int? activeCommentsCount;
  String? qualityText;
  bool? canWatch;
  int? viewsCount;
  String? description;
  bool? isUserFavoriteFilm;
  String? createdAt;

  DetailMusicMidel(
      {this.id,
      this.slug,
      this.name,
      this.musicAuthor,
      this.image,
      this.isFree,
      this.priceTypeName,
      this.type,
      this.likesCount,
      this.dislikesCount,
      this.isLike,
      this.isDisLike,
      this.activeCommentsCount,
      this.qualityText,
      this.canWatch,
      this.viewsCount,
      this.description,
      this.isUserFavoriteFilm,
      this.createdAt});

  DetailMusicMidel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    musicAuthor = json['music_author'];
    image = json['image'];
    isFree = json['isFree'];
    priceTypeName = json['priceTypeName'];
    type = json['type'];
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
    isLike = json['isLike'];
    isDisLike = json['isDisLike'];
    activeCommentsCount = json['activeCommentsCount'];
    qualityText = json['qualityText'];
    canWatch = json['canWatch'];
    viewsCount = json['viewsCount'];
    description = json['description'];
    isUserFavoriteFilm = json['isUserFavoriteFilm'];
    createdAt = json['created_at'];
  }
}
