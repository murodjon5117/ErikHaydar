import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'category_page_model.dart';

class CategoryMusicModel {
  List<MusicModel>? items;
  Meta? mMeta;

  CategoryMusicModel({this.items, this.mMeta});

  CategoryMusicModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <MusicModel>[];
      json['items'].forEach((v) {
        items!.add(MusicModel.fromJson(v));
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
