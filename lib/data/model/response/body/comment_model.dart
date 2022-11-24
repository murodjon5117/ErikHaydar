class CommetModel {
  List<Comment>? items;
  Meta? mMeta;

  CommetModel({this.items, this.mMeta});

  CommetModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Comment>[];
      json['items'].forEach((v) {
        items!.add(Comment.fromJson(v));
      });
    }
    mMeta = json['_meta'] != null ? Meta.fromJson(json['_meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }

    if (mMeta != null) {
      data['_meta'] = mMeta!.toJson();
    }
    return data;
  }
}

class Comment {
  int? id;
  String? userFullName;
  String? userImg;
  String? comment;
  String? createdAt;

  Comment(
      {this.id, this.userFullName, this.userImg, this.comment, this.createdAt});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userFullName = json['userFullName'];
    userImg = json['userImg'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userFullName'] = userFullName;
    data['userImg'] = userImg;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    return data;
  }
}

class Meta {
  int? totalCount;
  int? pageCount;
  int? currentPage;
  int? perPage;

  Meta({this.totalCount, this.pageCount, this.currentPage, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    data['currentPage'] = currentPage;
    data['perPage'] = perPage;
    return data;
  }
}
