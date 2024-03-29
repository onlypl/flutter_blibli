import 'package:blibli/http/core/hi_net.dart';
import 'package:blibli/http/request/base_request.dart';
import 'package:blibli/http/request/favorite_request.dart';
import 'package:blibli/util/log.dart';

class FavorriteDao{
  static favorite(String vid,bool favorite) async{
    BaseRequest request = favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    Log().debug(result);
    return result;
  }
}