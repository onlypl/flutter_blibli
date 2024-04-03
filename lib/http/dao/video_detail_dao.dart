import 'package:hi_base/log.dart';
import 'package:hi_net/hi_net.dart';
import 'package:blibli/http/request/video_detail_request.dart';
import 'package:blibli/model/video_detail_model.dart';
class VideoDetailDao{
  static get(String vid) async{
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
   var result = await HiNet.getInstance().fire(request);
    Log().debug(result);
    return VideoDetailModel.fromJson(result['data']);
  }
}