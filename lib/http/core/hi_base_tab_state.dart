import 'package:flutter/material.dart';
import 'package:hi_net/core/hi_error.dart';
import 'hi_state.dart';
import '../../util/color.dart';
import '../../util/log.dart';
import '../../util/toast.dart';
abstract class HiBaseTabState<M,L,T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  /// 列表
  List<L> dataList = [];

  /// 第一页
  int pageIndex = 1; //数据页码

  /// 加载状态
  bool loading = false;

  /// 控制器
  final ScrollController scrollController = ScrollController();
  get contentChild;

  /// 页面缓存
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState(); //最大滚动距离-当前滚动距离 =还差多远距离
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
     // Log().info('dis:$dis');
      // fix 当列表高度不满屏幕高度时不执行加载更多
        if (dis < 300 && !loading && scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

///获取对应页码的数据
  Future<M> getData(int pageIndex);
/// 从MO中解析出list数据
   List<L> parseList(M result);

/// 加载数据
  Future<void> loadData({loadMore = false}) async {
    if(loading){
        Log().error('上次数据还在加载中...');
        return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    Log().info('当前页码:$currentIndex');
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          //合并数组
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).isNotEmpty) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });

      Future.delayed(const Duration(milliseconds: 100));
      loading = false;
    } on NeedAuth catch (e) {
      Log().error(e);
      loading = false;
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      Log().error(e);
      loading = false;
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      Log().error(e);
      loading = false;
      showWarnToast(e.message);
    }
  }

    @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: primary,
      onRefresh: () {
        return loadData();
      },
      child: MediaQuery.removeViewPadding(
        //移除内间距
        removeTop: true,
        context: context,
        child: contentChild
      ),
    );
  }

}