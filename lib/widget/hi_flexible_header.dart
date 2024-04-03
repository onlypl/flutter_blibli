import 'package:blibli/provider/theme_provider.dart';
import 'package:hi_base/log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hi_base/view_util.dart';

///可动态改变位置的header组件
///性能优化：局部刷新的应用@刷新原理
class HiFilexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;
  const HiFilexibleHeader(
      {super.key,
      required this.name,
      required this.face,
      required this.controller});

  @override
  State<HiFilexibleHeader> createState() => _HiFilexibleHeaderState();
}

class _HiFilexibleHeaderState extends State<HiFilexibleHeader> {
  static const double  maxBottom = 40;
  static const double minBottom = 10;
  //滚动范围
  static const maxOffset = 80;
  double _dyBottom = maxBottom;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      Log().info('offset:$offset');
      //算出padding变化0-1
      var dyOffset = (maxOffset - offset) / maxOffset;
      //根据byOffset算出具体的变化padding值
      var dy = dyOffset * (maxBottom - minBottom);
      //临界值保护
      if (dy > (maxBottom - minBottom)) {
        dy = maxBottom - minBottom;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        //算出实际padding
        _dyBottom = minBottom + dy;
      });
      Log().info('_dyBottom:$_dyBottom');
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider =  context.watch<ThemeProvider>();
    Color nameColor = themeProvider.isDark(context)?Colors.white :Colors.black87;
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 10, bottom:_dyBottom),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            widget.name,
            style: TextStyle(fontSize: 13, color:nameColor),
          ),
        ],
      ),
    );
  }
}
