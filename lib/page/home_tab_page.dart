// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/model/home_mo.dart';
import 'package:blibli/util/toast.dart';
import 'package:blibli/widget/hi_banner.dart';
import 'package:blibli/widget/video_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../http/core/hi_error.dart';
import '../http/dao/home_dao.dart';
import '../util/log.dart';

class HomTabPage extends StatefulWidget {
  final String? categoryName;
  final List<BannerMo>? bannerList;
  const HomTabPage({
    super.key,
    this.categoryName,
    this.bannerList,
  });

  @override
  State<HomTabPage> createState() => _HomTabPageState();
}

class _HomTabPageState extends State<HomTabPage> {
  List<VideoMo> videoList = [];
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
      //移除内间距
      removeTop: true,
      context: context,
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Column(
            children: [
              if (widget.bannerList != null) _banner(widget.bannerList!),
              _videoItemView(),
            ],
          ),
        ],
      ),
    );
  }

  _banner(List<BannerMo> bannerList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(bannerList: bannerList),
    );
  }

  void _loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeDao.get(widget.categoryName ?? '',
          pageIndex: currentIndex, pageSize: 50);
      setState(() {
        if (loadMore) {
          //合并数组
          videoList = [...videoList, ...?result.videoList];
          if ((result.videoList ?? []).isNotEmpty) {
            pageIndex++;
          }
        } else {
          videoList = result.videoList ?? [];
        }
      });

      // Log().info('加载视频列表数据:$result');
    } on NeedAuth catch (e) {
      Log().error(e);
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      Log().error(e);
      showWarnToast(e.message);
    } catch (e) {
      Log().error(e);
      showWarnToast(e.toString());
    }
  }

  _videoItemView() {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: videoList.length,
        shrinkWrap: true,
        //解决无线高度问题
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            child: VideoCard(videoMo: videoList[index]),
          );
        });
  }
}
