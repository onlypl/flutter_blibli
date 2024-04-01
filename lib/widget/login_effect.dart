// ignore_for_file: public_member_api_docs, sort_constructors_first
//登录动效3
import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  const LoginEffect({
    super.key,
    required this.protect,
  });
  final bool protect;
  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(bottom: BorderSide(color: (Colors.grey[100])!))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              _image(true),
              const Image(
                height: 90,
                width: 90,
                image: AssetImage('assets/images/logo.png')),
              _image(false),
          ],
        ),
        );
  }
  _image(bool left){
    var headLeft = widget.protect ?'assets/images/head_left_protect.png':'assets/images/head_left.png';
    var headRight = widget.protect ?'assets/images/head_right_protect.png':'assets/images/head_right.png';
    return Image(height: 90,image: AssetImage(left?headLeft:headRight));
  }
}
