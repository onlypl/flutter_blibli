// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/model/home_model.dart';
import 'package:blibli/widget/hi_banner.dart';
import 'package:blibli/widget/video_card.dart';
import 'package:flutter/material.dart';
import '../http/core/hi_base_tab_state.dart';
import '../http/dao/home_dao.dart';
import '../model/video_model.dart';
import '../util/log.dart';

class HomTabPage extends StatefulWidget {
  final String? categoryName;
  final List<BannerModel>? bannerList;
  const HomTabPage({
    super.key,
    this.categoryName,
    this.bannerList,
  });

  @override
  State<HomTabPage> createState() => _HomTabPageState();
}

class _HomTabPageState
    extends HiBaseTabState<HomeModel, VideoModel, HomTabPage> {
  @override
  void initState() {
    super.initState();
    Log().debug(widget.categoryName);
    Log().debug(widget.bannerList);
  }

  _banner(List<BannerModel> bannerList) {
    return HiBanner(
      bannerList: bannerList,
      panding: const EdgeInsets.only(left: 5, right: 5, top: 10),
    );
  }

  _videoItemListView() {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: dataList.length,
        shrinkWrap: true,
        //解决无线高度问题
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return VideoCard(videoModel: dataList[index]);
        });
  }

  @override
  get contentChild => ListView(
        physics: const AlwaysScrollableScrollPhysics(), //页面数量不足无法滚动告诉列表允许滚动
        controller: scrollController,
        children: [
          Column(
            children: [
              if (widget.bannerList != null) _banner(widget.bannerList!),
              _videoItemListView(), //视频列表
            ],
          ),
        ],
      );

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result = await HomeDao.get(widget.categoryName ?? '',
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeModel result) {
    return result.videoList ?? [];
  }
}
