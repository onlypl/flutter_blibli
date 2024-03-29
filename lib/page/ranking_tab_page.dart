import 'package:blibli/http/core/hi_base_tab_state.dart';
import 'package:blibli/http/dao/ranking_dao.dart';
import 'package:blibli/model/ranking_model.dart';
import 'package:blibli/model/video_model.dart';
import 'package:blibli/widget/video_large_card.dart';
import 'package:flutter/material.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;
  const RankingTabPage({super.key, required this.sort});

  @override
  State<RankingTabPage> createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingModel, VideoModel, RankingTabPage> {
  buildVideoList() {
    return dataList
        .map((VideoModel videoModel) => VideoLargeCard(videoModel: videoModel));
  }
  @override
  get contentChild => ListView(
        physics: const AlwaysScrollableScrollPhysics(), //页面数量不足无法滚动告诉列表允许滚动
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        children: [
          ...buildVideoList(),
        ],
      );

  @override
  Future<RankingModel> getData(int pageIndex) async {
    RankingModel result = await RankingDao.get(
        sort: widget.sort, pageIndex: pageIndex, pageSize: 20);
    return result;
  }

  @override
  List<VideoModel> parseList(RankingModel result) {
    return result.list ?? [];
  }
}
