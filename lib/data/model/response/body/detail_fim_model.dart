class DetailFilmModel {
  int? id;
  String? slug;
  String? name;
  String? image;
  bool? isFree;
  bool? isLike;
  bool? isDisLike;
  String? createdAt;
  String? priceTypeName;
  String? type;
  String? category;
  int? likesCount;
  int? dislikesCount;
  int? partsCount;
  int? seasonsCount;
  int? activeCommentsCount;
  bool? isSerial;
  String? qualityText;
  bool? canWatch;
  int? viewsCount;
  String? description;
  bool? isUserFavoriteFilm;

  DetailFilmModel(
      {this.id,
      this.slug,
      this.name,
      this.image,
      this.isFree,
      this.isLike,
      this.isDisLike,
      this.createdAt,
      this.priceTypeName,
      this.type,
      this.category,
      this.likesCount,
      this.dislikesCount,
      this.partsCount,
      this.seasonsCount,
      this.activeCommentsCount,
      this.isSerial,
      this.qualityText,
      this.canWatch,
      this.viewsCount,
      this.description,
      this.isUserFavoriteFilm});

  DetailFilmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    image = json['image'];
    isFree = json['isFree'];
    isLike = json['isLike'];
    isDisLike = json['isDisLike'];
    createdAt = json['created_at'];
    priceTypeName = json['priceTypeName'];
    type = json['type'];
    category = json['category'];
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
    partsCount = json['partsCount'];
    seasonsCount = json['seasonsCount'];
    activeCommentsCount = json['activeCommentsCount'];
    isSerial = json['isSerial'];
    qualityText = json['qualityText'];
    canWatch = json['canWatch'];
    viewsCount = json['viewsCount'];
    description = json['description'];
    isUserFavoriteFilm = json['isUserFavoriteFilm'];
  }
}
