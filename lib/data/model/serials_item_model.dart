class SerialItems {
  Parts? parts;

  SerialItems({ this.parts});

  SerialItems.fromJson(Map<String, dynamic> json) {
    parts = json['parts'] != null ? Parts.fromJson(json['parts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    if (parts != null) {
      data['parts'] = parts!.toJson();
    }
    return data;
  }
}

class Parts {
  List<SerialsItems>? items;
  Meta? mMeta;

  Parts({this.items, this.mMeta});

  Parts.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SerialsItems>[];
      json['items'].forEach((v) {
        items!.add(SerialsItems.fromJson(v));
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

class SerialsItems {
  int? id;
  String? slug;
  String? name;
  String? image;
  String? sources;

  SerialsItems({this.id, this.slug, this.name, this.image, this.sources});

  SerialsItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    image = json['image'];
    sources = json['sources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    data['image'] = image;
    data['sources'] = sources;
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
