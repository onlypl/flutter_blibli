// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers, avoid_print
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';

import 'package:blibli/model/video_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;
  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(listener = (current,pre){
         print("current:${current.page}");
        print("pre:${pre.page}");
        if(widget == current.page || current.page is HomePage){
          print('打开了首页:onResume');
        }else if(widget == pre?.page || pre?.page is HomePage){
          print('打开了首页:onPause');
        }
    });
  }
  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:  Container(
          child: Column(
            children: [
              const Text('首页'),
              MaterialButton(
                child:const Text('详情'),
                onPressed: (){
                  HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args:{'VideoModel':VideoModel(vid: 123)});
                },
                )
            ],
          ),
        ),
    );
  }
}