import 'package:blibli/model/profile_model.dart';
import 'package:blibli/widget/hi_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class BenefitCartd extends StatelessWidget {
  final List<BenefitModel> benefitList;
  const BenefitCartd({super.key, required this.benefitList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
      child: Column(
        children: [
          _buildTitle(context),
          _buildBenefitList(context),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
     var themeProvider =  context.watch<ThemeProvider>();
     Color titleColor = themeProvider.isDark(context)?Colors.white70 :Colors.black87;
      Color subTitleColor = themeProvider.isDark(context)? Colors.white54:Colors.black45;
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child:  Row(
        children: [
          Text(
            '增值服务',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color:titleColor),
          ),
          const SizedBox(width: 10),
          Text('购买后登录官网再次点击打开',
              style: TextStyle(fontSize: 14, color:subTitleColor)),
        ],
      ),
    );
  }

  _buildCard(BuildContext context, BenefitModel? model, double width) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60.w,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Stack(
              children: [
                const Positioned.fill(child: HiBlur()),
                Positioned.fill(
                    child: Center(
                  child: Text(
                    model?.name ?? '',
                    style: const TextStyle(color: Colors.white54),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBenefitList(BuildContext context) {
    //根据卡片数量算出每个卡片的宽度
    var width =
        ((ScreenUtil().screenWidth - 20) - (benefitList.length - 1) * 5) /
            benefitList.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...benefitList
            .map((model) => _buildCard(context, model, width))
            .toSet(),
      ],
    );
  }
}
