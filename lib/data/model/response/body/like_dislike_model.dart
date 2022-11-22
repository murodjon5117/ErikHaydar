class LikeDislikeModel {
  int? likesCount;
  int? dislikesCount;

  LikeDislikeModel({this.likesCount, this.dislikesCount});

  LikeDislikeModel.fromJson(Map<String, dynamic> json) {
    likesCount = json['likesCount'];
    dislikesCount = json['dislikesCount'];
  }
}
