import 'package:flutter/material.dart';

import 'barrage_model.dart';

class BarrageViewUtil {
  //如果想定义弹幕样式，可以这里根据弹幕类型来定义
  static barrageView(BarrageModel model) {
    switch (model.type) {
      case 1:
        return _barrageType1(model);
    }
    return Text(
      model.content,
      style: const TextStyle(color: Colors.white),
    );
  }

  static _barrageType1(BarrageModel model) {
    return Center(
      child: Container(
        padding:const EdgeInsets.only(left: 10,right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          model.content,
          style: const TextStyle(color: Colors.amber),
        ),
      ),
    );
  }
}
