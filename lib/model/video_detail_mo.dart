import 'video_model.dart';


class VideoDetailMo {
  bool? isFavorite;
  bool? isLike;
  VideoModel? videoInfo;
  List<VideoModel>? videoList;

  VideoDetailMo({this.isFavorite, this.isLike, this.videoInfo, this.videoList});

  VideoDetailMo.fromJson(Map<String, dynamic> json) {
    isFavorite = json['isFavorite'];
    isLike = json['isLike'];
    videoInfo = json['videoInfo'] != null
        ? VideoModel.fromJson(json['videoInfo'])
        : null;
    if (json['videoList'] != null) {
      videoList = <VideoModel>[];
      json['videoList'].forEach((v) {
        videoList!.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFavorite'] = isFavorite;
    data['isLike'] = isLike;
    if (videoInfo != null) {
      data['videoInfo'] = videoInfo!.toJson();
    }
    if (videoList != null) {
      data['videoList'] = videoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}