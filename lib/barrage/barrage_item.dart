// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/barrage/barrage_transition.dart';
import 'package:flutter/material.dart';

//弹幕widget
class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged? onComplete;
  final Duration duration;
  BarrageItem({
    super.key,
    required this.id,
    required this.child,
    required this.top,
    required this.onComplete,
    this.duration = const Duration(milliseconds: 9000),
  });
//fix 动画状态错乱
  final _key = GlobalKey<BarrageTransitionState>();
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
            key: _key,
            child: child,
            duration: duration,
            onComplete:(v){
              onComplete!(id);
            }, ));
  }
}
