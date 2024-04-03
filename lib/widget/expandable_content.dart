// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hi_base/log.dart';
import 'package:hi_base/view_util.dart';
import 'package:flutter/material.dart';
import '../model/video_model.dart';

///可展开的空间
class ExpandableContent extends StatefulWidget {
  const ExpandableContent({
    super.key,
    required this.mo,
  });

  final VideoModel mo;

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  //用来管理Animation
  late AnimationController _controller;

  bool _expand = false;
  //生成动画高度的值
  late Animation<double> _heightFactor;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _controller.addListener(() {
      //监听动画值变化
      Log().info(_heightFactor.value);
    });
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, //保证交叉轴的箭头位置局上
        children: [
          //通过Expanded让Text获取最大宽度 以便显示省略号
          Expanded(
            child: Text(
              widget.mo.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              _expand
                  ? Icons.keyboard_arrow_up_sharp
                  : Icons.keyboard_arrow_down_sharp,
              size: 20,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        //执行动画
        _controller.forward();
      } else {
        //反向执行动画
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          _buildInfo(),
          _bulidDes(),
        ],
      ),
    );
  }

  ///视频信息
  _buildInfo() {
    var style = const TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = ((widget.mo.createTime) ?? "").length > 10
        ? widget.mo.createTime?.substring(5, 10)
        : widget.mo.createTime;
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.mo.view,
            textLeft: 3, style: style),
        const Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.mo.reply,
            textLeft: 3, style: style),
        const Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(null, dateStr, textLeft: 3, style: style),
      ],
    );
  }

  ///视频描述
  _bulidDes() {
    var child = _expand
        ? Text(widget.mo.desc ?? "",
            style: const TextStyle(fontSize: 12, color: Colors.grey))
        : null;
     //构建动画的通用widget
    return AnimatedBuilder(
      animation: _controller.view, 
       child: child,
       builder: (context, child) {
          return Align(//精准控制组件位置
               heightFactor: _heightFactor.value,
               //fix从布局之上的位置开始展开
               alignment: Alignment.topCenter,
               child: Container( //会撑满宽度后 让内容对齐
                alignment: Alignment.topLeft,
                padding:const EdgeInsets.only(top: 8),
                child:child,
               ),
          );
       },
    );
  }
}
