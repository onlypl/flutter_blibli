// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chewie/chewie.dart'; //隐藏三方的播放控制器
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:hi_base/color.dart';
import 'hi_video_controls.dart';
import 'package:hi_base/view_util.dart';
//播放器组件
class VideoView extends StatefulWidget {
  final String url; //视频url
  final String? cover; //封面
  final bool autoPlay; //是否自动播放
  final bool looping; //是否循环播放
  final double aspectRatio; //宽/高缩放比例
  final Widget? overlayUI;
  final Widget? barrageUI; //弹幕UI
  const VideoView({
    super.key,
    required this.url,
    this.cover,
    this.autoPlay = true,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.overlayUI,
    this.barrageUI,
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController; //video_plater播放器Controller
  late ChewieController _chewieController; //chewie播放器Controller
  //封面
  get _placeholder=> FractionallySizedBox(
      widthFactor: 1,
      child:  cachedImage(widget.cover ?? ""),
  );
  get _progressColors => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50]!,
  );
  @override
  void initState() {
    super.initState();
    //初始化播放器设置
    _videoPlayerController =
        VideoPlayerController.networkUrl(
        //  Uri.parse(widget.url));
          Uri.parse('https://vjs.zencdn.net/v/oceans.mp4'));      
    _chewieController = ChewieController(
     // allowedScreenSleep: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      looping: widget.looping,
      autoPlay: widget.autoPlay,
      allowMuting: false, //是否显示禁音按钮
      allowPlaybackSpeedChanging: false,//是否显示倍速
      
      placeholder: _placeholder,
      customControls: HiMaterialControls(//自定义控制器
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(fromTop: false),
          overlayUI: widget.overlayUI,
          barrageUI: widget.barrageUI,
      ),
      materialProgressColors: _progressColors
    );
    _chewieController.addListener(_fullScreenListener); //全屏变化监听
  }
  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth/widget.aspectRatio; //根据宽度和宽高比例获取高度
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController
        ),
    );
  }


///全屏切换竖屏监听
  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if(size.width >size.height){
       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }
}
