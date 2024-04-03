import 'package:hi_net/hi_net.dart';
import 'package:blibli/http/request/favorite_request.dart';
import 'package:hi_base/log.dart';
import '../request/base_request.dart';
class FavorriteDao{
  static favorite(String vid,bool favorite) async{
    BaseRequest request = favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    Log().debug(result);
    return result;
  }
}