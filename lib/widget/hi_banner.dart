// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/util/log.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../model/home_model.dart';
import '../model/video_model.dart';

class HiBanner extends StatefulWidget {
  final List<BannerModel> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? panding;
  const HiBanner({
    super.key,
    required this.bannerList,
    this.bannerHeight = 160,
    this.panding,
  });

  @override
  State<HiBanner> createState() => _HiBannerState();
}

class _HiBannerState extends State<HiBanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (widget.panding?.horizontal ?? 0) / 2;
    return Swiper(
      pagination: const SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: 5, bottom: 10),
        builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: primary,
            size: 10,
            activeSize: 10,
            space: 3),
      ),
      itemCount: widget.bannerList.length,
      autoplay: true, //自动滚动
      itemBuilder: (context, index) {
        return _image(widget.bannerList[index], right);
      },
    );
  }

  _image(BannerModel? bannerMo, double right) {
    return InkWell(
      onTap: () {
        Log().info(bannerMo?.title ?? "");
        _handleClick(bannerMo);
      },
      child: Container(
        padding: widget.panding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            bannerMo?.cover ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerModel? bannerMo) {
    if(bannerMo == null){
        return;
    }
    if (bannerMo.type == "video") {
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'videoModel': VideoModel(vid: bannerMo.url)});
          Log().info("跳转逻辑");
    }else{
      Log().info(bannerMo.url);
    }
  }
}
