// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/util/color.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';

///弹幕输入界面
class BarrageInput extends StatelessWidget {
  final VoidCallback? onTabClose;
  const BarrageInput({
    super.key,
    this.onTabClose,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          //空白区域点击关闭弹窗
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onTabClose != null) {
                onTabClose!();
              }
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),
          SafeArea(
              child: Container(
            color: Colors.white,
            child: Row(
              children: [
                hiSpace(width: 15),
                _buildInput(textEditingController, context),
                _buildSendBtn(textEditingController,context),
              ],
            ),
          )),
        ],
      ),
    );
  }
///输入框
  _buildInput(
      TextEditingController textEditingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(26)),
      child: TextField(
        autofocus: true, //获取焦点
        controller: textEditingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: primary,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
          hintText: '发送个友善的弹幕见证当下',
        ),
      ),
    ));
  }
  ///发送消息
  void _send(String text, BuildContext context) {
    if(text.isNotEmpty){
        if(onTabClose != null){
            onTabClose!();
            Navigator.pop(context,text);
        }
    }
  }
  //发送按钮
  _buildSendBtn(TextEditingController textEditingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = textEditingController.text.trim();
        _send(text, context);
      },
      child:Container(
        padding:const EdgeInsets.only(right: 10,left: 10),
        child:const Icon(Icons.send_rounded,color: Colors.grey,),
      ) ,
    );
  }
}
