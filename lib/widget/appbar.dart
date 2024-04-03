//自定义顶部appBar
import 'package:hi_base/view_util.dart';
import 'package:flutter/material.dart';

appbar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    centerTitle: true,
    titleSpacing: 0,
    leading: const BackButton(),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}


///视频详情页appbar
videoAppBar(){
  return Container(
    padding: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child:const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          children: [
                Icon(Icons.live_tv_rounded,color:Colors.white ,size: 20,),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.more_vert_rounded,color:Colors.white ,size: 20,),
            ),
            
          ],
        )
      ],
    ),
  );
}