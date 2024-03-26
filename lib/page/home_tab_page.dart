// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/model/home_mo.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/util/toast.dart';
import 'package:blibli/widget/hi_banner.dart';
import 'package:blibli/widget/video_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

class _HomTabPageState extends State<HomTabPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoMo> videoList = [];
  int pageIndex = 1; //数据页码
  bool _loading = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState(); //最大滚动距离-当前滚动距离 =还差多远距离
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      Log().info('dis:$dis');
      if (dis < 300 && !_loading) {
        _loadData(loadMore: true);
      }
    });

    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: primary,
      onRefresh: () {
        return _loadData();
      },
      child: MediaQuery.removeViewPadding(
        //移除内间距
        removeTop: true,
        context: context,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(), //页面数量不足无法滚动告诉列表允许滚动
          controller: _scrollController,
          children: [
            Column(
              children: [
                if (widget.bannerList != null) _banner(widget.bannerList!),
                _videoItemListView(), //视频列表
              ],
            ),
          ],
        ),
      ),
    );
  }

  _banner(List<BannerMo> bannerList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: HiBanner(bannerList: bannerList),
    );
  }

  Future<void> _loadData({loadMore = false}) async {
    _loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    Log().info('$currentIndex');
    try {
      HomeMo result = await HomeDao.get(widget.categoryName ?? '',
          pageIndex: currentIndex, pageSize: 10);
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
      Future.delayed(const Duration(milliseconds: 100));
      _loading = false;
      // Log().info('加载视频列表数据:$result');
    } on NeedAuth catch (e) {
      Log().error(e);
      _loading = false;
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      Log().error(e);
      _loading = false;
      showWarnToast(e.message);
    } catch (e) {
      Log().error(e);
      _loading = false;
      showWarnToast(e.toString());
    }
  }

  _videoItemListView() {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: videoList.length,
        shrinkWrap: true,
        //解决无线高度问题
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return VideoCard(videoMo: videoList[index]);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
