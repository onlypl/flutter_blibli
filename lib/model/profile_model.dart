
import 'home_model.dart';

class ProfileModel {
  String? name;
  String? face;
  int? fans;
  int? favorite;
  int? like;
  int? coin;
  int? browsing;
  List<BannerModel>? bannerList;
  List<CourseModel>? courseList;
  List<BenefitModel>? benefitList;

  ProfileModel(
      {this.name,
      this.face,
      this.fans,
      this.favorite,
      this.like,
      this.coin,
      this.browsing,
      this.bannerList,
      this.courseList,
      this.benefitList});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    browsing = json['browsing'];
    if (json['bannerList'] != null) {
      bannerList = <BannerModel>[];
      json['bannerList'].forEach((v) {
        bannerList!.add(BannerModel.fromJson(v));
      });
    }
    if (json['courseList'] != null) {
      courseList = <CourseModel>[];
      json['courseList'].forEach((v) {
        courseList!.add(CourseModel.fromJson(v));
      });
    }
    if (json['benefitList'] != null) {
      benefitList = <BenefitModel>[];
      json['benefitList'].forEach((v) {
        benefitList!.add(BenefitModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['face'] = face;
    data['fans'] = fans;
    data['favorite'] = favorite;
    data['like'] = like;
    data['coin'] = coin;
    data['browsing'] = browsing;
    if (bannerList != null) {
      data['bannerList'] = bannerList!.map((v) => v.toJson()).toList();
    }
    if (courseList != null) {
      data['courseList'] = courseList!.map((v) => v.toJson()).toList();
    }
    if (benefitList != null) {
      data['benefitList'] = benefitList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseModel {
  String? name;
  String? cover;
  String? url;
  int? group;

  CourseModel({this.name, this.cover, this.url, this.group});

  CourseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cover'] = cover;
    data['url'] = url;
    data['group'] = group;
    return data;
  }
}

class BenefitModel {
  String? name;
  String? url;

  BenefitModel({this.name, this.url});

  BenefitModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}