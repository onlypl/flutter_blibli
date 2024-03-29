import 'video_model.dart';

class HomeMo {
  List<BannerMo>? bannerList;
  List<CategoryMo>? categoryList;
  List<VideoModel>? videoList;

  HomeMo({this.bannerList, this.categoryList, this.videoList});

  HomeMo.fromJson(Map<String, dynamic> json) {
    if (json['bannerList'] != null) {
      bannerList = <BannerMo>[];
      json['bannerList'].forEach((v) {
        bannerList!.add(BannerMo.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = <CategoryMo>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(CategoryMo.fromJson(v));
      });
    }
    if (json['videoList'] != null) {
      videoList = <VideoModel>[];
      json['videoList'].forEach((v) {
        videoList!.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bannerList != null) {
      data['bannerList'] = bannerList!.map((v) => v.toJson()).toList();
    }
    if (categoryList != null) {
      data['categoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }
    if (videoList != null) {
      data['videoList'] = videoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerMo {
  String? id;
  int? sticky;
  String? type;
  String? title;
  String? subtitle;
  String? url;
  String? cover;
  String? createTime;

  BannerMo(
      {this.id,
      this.sticky,
      this.type,
      this.title,
      this.subtitle,
      this.url,
      this.cover,
      this.createTime});

  BannerMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sticky = json['sticky'];
    type = json['type'];
    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
    cover = json['cover'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sticky'] = sticky;
    data['type'] = type;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['url'] = url;
    data['cover'] = cover;
    data['createTime'] = createTime;
    return data;
  }
}

class CategoryMo {
  String? name;
  int? count;

  CategoryMo({this.name, this.count});

  CategoryMo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}