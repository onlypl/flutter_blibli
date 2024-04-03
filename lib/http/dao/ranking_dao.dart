import 'package:hi_net/hi_net.dart';
import 'package:blibli/http/request/ranking_request.dart';
import 'package:blibli/model/ranking_model.dart';

class RankingDao {
  static get({required String sort, pageIndex = 1, pageSize = 20}) async {
    RankingRequest request = RankingRequest();
    request
        .add('sort', sort)
        .add('pageIndex', pageIndex)
        .add('pageSize', pageSize);
    var result = await HiNet.getInstance().fire(request);
    return RankingModel.fromJson(result['data']); 
  }
}
