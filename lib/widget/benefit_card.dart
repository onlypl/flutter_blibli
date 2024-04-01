import 'package:blibli/model/profile_model.dart';
import 'package:blibli/widget/hi_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BenefitCartd extends StatelessWidget {
  final List<BenefitModel> benefitList;
  const BenefitCartd({super.key, required this.benefitList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          _buildBenefitList(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: const Row(
        children: [
          Text(
            '增值服务',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87),
          ),
          SizedBox(width: 10),
          Text('购买后登录XXz再次点击打开',
              style: TextStyle(fontSize: 14, color: Colors.black45)),
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
