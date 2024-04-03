// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hi_base/color.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//带lottie动画的加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  ///加载动画是否覆盖在原有页面上
  final bool cover;
  const LoadingContainer({
    super.key,
    required this.child,
    required this.isLoading,
    this.cover = false, //为true表示和页面不共存
  });

  @override
  Widget build(BuildContext context) {
    if(cover){//是否覆盖原有界面上
        return Stack(
          children: [
            child, isLoading?_loadingView:Container(),
          ],
        );
    }else{
     return isLoading?_loadingView:child;
    }

  }
  
 Widget get  _loadingView{
  //return Center(child: Lottie.asset('assets/loading.json'));
   return Center(child: LoadingAnimationWidget.stretchedDots(color: primary, size: 60));
  }
}
