import 'package:blibli/http/core/hi_net.dart';
import 'package:blibli/http/request/home_request.dart';
import 'package:blibli/model/home_mo.dart';
import 'package:logger/web.dart';

import '../../util/log.dart';

class HomeDao{
  static get(String categoryName, {int pageIndex = 1,int pageSize = 10}) async{
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result =  await HiNet.getInstance().fire(request);
    Log().debug(result);
    return HomeMo.fromJson(result['data']);
  }
}