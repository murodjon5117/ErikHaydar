class NotificationModel {
  List<NotifItems>? items;
  Meta? mMeta;

  NotificationModel({this.items, this.mMeta});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <NotifItems>[];
      json['items'].forEach((v) {
        items!.add(NotifItems.fromJson(v));
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

class NotifItems {
  int? id;
  String? title;
  String? content;
  int? typeId;
  String? createdAt;

  NotifItems({this.id, this.title, this.content, this.typeId, this.createdAt});

  NotifItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['type_id'] = typeId;
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
