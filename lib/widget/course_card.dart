import 'package:blibli/model/profile_model.dart';
import 'package:blibli/provider/theme_provider.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final List<CourseModel> courseList;
  const CourseCard({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 12),
      child: Column(
        children: [
          _buildTitle(context),
          ..._buildCardList(context),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
     var themeProvider =  context.watch<ThemeProvider>();
     Color titleColor = themeProvider.isDark(context)?Colors.white70 :Colors.black87;
      Color subTitleColor = themeProvider.isDark(context)? Colors.white54:Colors.black45;
    return Container(
      padding:const EdgeInsets.only(bottom: 5),
      child:  Row(
        children: [
          Text(
            '职场进阶',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: titleColor),
          ),
         const SizedBox(width: 10),
          Text('带你突破技术瓶颈',
              style: TextStyle(fontSize: 14, color: subTitleColor)),
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
