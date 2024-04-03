import 'package:hi_net/hi_net.dart';
import 'package:blibli/http/request/profile_request.dart';
import 'package:blibli/model/profile_model.dart';

class ProfileDao{
  static get() async{
    ProfileRequest request = ProfileRequest();
    var result  = await HiNet.getInstance().fire(request);
     return ProfileModel.fromJson(result['data']); 
  }
}