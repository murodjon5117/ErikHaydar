import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';

class CategoryPageModel {
  Items? category;
  FilmsAll? films;

  CategoryPageModel({this.category, this.films});

  CategoryPageModel.fromJson(Map<String, dynamic> json) {
    category =
        json['category'] != null ? Items.fromJson(json['category']) : null;
    films = json['films'] != null ? FilmsAll.fromJson(json['films']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (films != null) {
      data['films'] = films!.toJson();
    }
    return data;
  }
}

class FilmsAll {
  List<Films>? items;
  Meta? mMeta;

  FilmsAll({this.items, this.mMeta});

  FilmsAll.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Films>[];
      json['items'].forEach((v) {
        items!.add(Films.fromJson(v));
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
