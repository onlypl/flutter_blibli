import 'package:blibli/model/profile_model.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCard extends StatelessWidget {
  final List<CourseModel> courseList;
  const CourseCard({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 12),
      child: Column(
        children: [
          _buildTitle(),
          ..._buildCardList(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding:const EdgeInsets.only(bottom: 5),
      child: const Row(
        children: [
          Text(
            '职场进阶',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87),
          ),
          SizedBox(width: 10),
          Text('带你突破技术瓶颈',
              style: TextStyle(fontSize: 14, color: Colors.black45)),
        ],
      ),
    );
  }

  ///动态布局
  _buildCardList(BuildContext context) {
    var courseGroup = {};
  //  CourseModel mo = courseList[4];
  //  mo.group = 1;
    //将课程进行分组
    for (var model in courseList) {
      if (!courseGroup.containsKey(model.group)) {
        courseGroup[model.group] = [];
      }
      List list = courseGroup[model.group];
      list.add(model);
    }
    return courseGroup.entries.map((e) {
      List tempList = e.value;
      //根据卡片数量算出每个卡片的宽度
      var width = ((ScreenUtil().screenWidth - 20) - (tempList.length - 1) * 5) /
          tempList.length;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...tempList.map((model) => _buildCard(model, width, height)).toSet()
        ],
      );
    });
  }

  _buildCard(CourseModel? model, double width, double height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: cachedImage(model?.cover ?? '', width: width, height: height),
        ),
      ),
    );
  }
}
