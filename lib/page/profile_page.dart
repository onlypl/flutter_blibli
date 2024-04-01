import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/dao/profile_dao.dart';
import 'package:blibli/model/home_model.dart';
import 'package:blibli/model/profile_model.dart';
import 'package:blibli/util/log.dart';
import 'package:blibli/util/view_util.dart';
import 'package:blibli/widget/benefit_card.dart';
import 'package:blibli/widget/course_card.dart';
import 'package:blibli/widget/hi_banner.dart';
import 'package:blibli/widget/hi_blur.dart';
import 'package:blibli/widget/hi_flexible_header.dart';
import 'package:blibli/widget/hi_tab.dart';
import 'package:flutter/material.dart';

import '../util/toast.dart';

//我的
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileModel? model;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return _buildAppBar();
          },
          body: ListView(
            padding: const EdgeInsets.only(top: 10),
            children: [..._buildContentList()],
          )),
    );
  }

  void loadData() async {
    try {
      var result = await ProfileDao.get();
      setState(() {
        model = result;
      });
    } on NeedLogin catch (e) {
      Log().error(e.message);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      Log().error(e.message);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      Log().error(e.message);
      showWarnToast(e.message);
    }
  }

  ///头部头像和用户名组件
  _buildHead() {
    if (model == null) return Container();
    return HiFilexibleHeader(
        name: model?.name ?? '',
        face: model?.face ?? '',
        controller: _scrollController);
  }

  ///头部组件
  _buildAppBar() {
    return <Widget>[
      SliverAppBar(
        //扩展高度
        expandedHeight: 160,
        //标题栏是否固定
        pinned: true,
        //滚动空间
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 0),
          collapseMode: CollapseMode.parallax,
          title: _buildHead(),
          background: Stack(
            children: [
              Positioned.fill(
                child: cachedImage(
                    'https://img1.baidu.com/it/u=2733322681,3127223369&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800'),
              ),
              const Positioned.fill(
                  child: HiBlur(
                sigma: 5,
              )),
              Positioned(
                  bottom: 0, left: 0, right: 0, child: _buildProfileTab()),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
  //内容列表
  _buildContentList() {
    if (model == null) {
      return [];
    }
    return [
      _buildBanner(),
      CourseCard(courseList: model?.courseList ?? []),
      BenefitCartd(benefitList: model?.benefitList ?? []),
    ];
  }

  ///轮播图
  _buildBanner() {
    return HiBanner(
      bannerList: model?.bannerList ?? [],
      bannerHeight: 120,
      panding: const EdgeInsets.only(left: 10, right: 10),
    );
  }

  ///资产模块
  _buildProfileTab() {
    if (model == null) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: const BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTextText('收藏', model?.favorite),
          _buildTextText('点赞', model?.like),
          _buildTextText('浏览', model?.browsing),
          _buildTextText('金币', model?.coin),
          _buildTextText('粉丝数', model?.fans),
        ],
      ),
    );
  }
  ///资产item组件
  _buildTextText(String title, int? favorite) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$favorite',
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3,),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
