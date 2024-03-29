
import 'package:blibli/model/video_model.dart';

class RankingModel {
  int? total;
  List<VideoModel>? list;

  RankingModel({this.total, this.list});

  RankingModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <VideoModel>[];
      json['list'].forEach((v) {
        list!.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

