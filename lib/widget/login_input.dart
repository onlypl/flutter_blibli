// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';
import '../util/log.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({
    super.key,
    required this.title,
    required this.hint,
    this.onChanged, 
    this.focusChanged,
    this.lineStretch = false, 
    this.obsureText = false, 
    this.keyboardType,
  });
  final String title;   //标题
  final String hint;    //提示
  final ValueChanged<String>? onChanged; //文本发生改变监听
  final ValueChanged<bool>? focusChanged; //是否获取到焦点监听
  final bool lineStretch; //线条是否无间距
  final bool obsureText;  //是否是密文
  final TextInputType? keyboardType; //键盘类型
  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _foucusNode = FocusNode(); //是否获取到光标
  @override
  void initState() {
    super.initState();
    //是否获取到焦点监听
    _foucusNode.addListener(() {
      Log().info("是否有焦点:${_foucusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_foucusNode.hasFocus);
      }
      
    });
  }

  @override
  void dispose() {
    _foucusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style:const TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
       
        Padding(
          padding: EdgeInsets.only(left:widget.lineStretch?0:15),
        child:const Divider(
            height: 1,  //高度
            thickness: 0.5,//粗细
        ),),
      ],
    ); //上下
  }

  _input(){
     return Expanded(
      child: TextField(
          focusNode: _foucusNode, //焦点控制
          onChanged: widget.onChanged, //文本发生改变
          obscureText: widget.obsureText, //是否是密文
          keyboardType: widget.keyboardType, //键盘类型
          autofocus: !widget.obsureText, //是否自动聚焦 明文为true
          cursorColor: primary, //光标颜色
          decoration: InputDecoration( //textField 样式
            hintText: widget.hint, //提示文字
            hintStyle: const TextStyle(fontSize: 15,color: Colors.grey),//提示文字样式
            border: InputBorder.none, //边框
            contentPadding:const EdgeInsets.only(left: 20, right: 20),//内间距
          ),
      ),
      );
  }
}
