// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, use_super_parameters
// ignore_for_file: avoid_unnecessary_containers

import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/dao/login_dao.dart';
import 'package:blibli/util/string_util.dart';
import 'package:blibli/util/toast.dart';
import 'package:blibli/widget/login_button.dart';
import 'package:flutter/material.dart';

import 'package:blibli/widget/appbar.dart';
import 'package:blibli/widget/login_effect.dart';
import 'package:blibli/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumpToLogin;
  const RegistrationPage({
    Key? key,
    this.onJumpToLogin,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  late String userName;
  late String password;
  late String rePassword;
  late String imoocId;
  late String orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar('注册', '登录', widget.onJumpToLogin ?? () {}),
        body: Container(
          child: ListView(
            //自适应键盘弹出 防止遮挡
            children: [
              LoginEffect(protect: protect),
              LoginInput(
                title: '用户名',
                hint: '请输入用户名',
                onChanged: (value) {
                  userName = value;
                  checkInput();
                },
              ),
              LoginInput(
                title: '密码',
                hint: '请输入密码',
                obsureText: true,
                onChanged: (value) {
                  password = value;
                  checkInput();
                },
                focusChanged: (value) {
                  setState(() {
                    protect = value;
                  });
                },
              ),
              LoginInput(
                title: '确认密码',
                hint: '请再次输入密码',
                obsureText: true,
                onChanged: (value) {
                  rePassword = value;
                  checkInput();
                },
                focusChanged: (value) {
                  setState(() {
                    protect = value;
                  });
                },
              ),
              LoginInput(
                title: '慕课网ID',
                hint: '请输入慕课网ID',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  imoocId = value;
                  checkInput();
                },
              ),
              LoginInput(
                title: '课程订单号',
                hint: '请输入课程订单号后四位',
                lineStretch: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  orderId = value;
                  checkInput();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: LoginButton(title: '注册',enable: loginEnable,onPressed: () {
                    checkParams();
                },),
              ),
            ],
          ),
        ));
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  // _loginButton() {
  //   return InkWell(
  //     onTap: () {
  //       if (loginEnable) {
  //         checkParams();
  //       } else {
  //         print('按钮不可点击');
  //       }
  //     },
  //     child: const Text(
  //       '注册',
  //       style: TextStyle(),
  //     ),
  //   );
  // }

  void send() async {
    try {
      var result =
          await LoginDao.registration(userName, password, imoocId, orderId);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
         showToast('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin!();
        }
      } else {
        print(result['msg']);
         showWarnToast(result['msg']);
      }
    } on NeedLogin catch (e) {
      print(e);
      showWarnToast(e.toString());
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.toString());
    } catch (e) {
      print(e);
      showWarnToast(e.toString());
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId.length != 4) {
      tips = '请输入订单号后四位';
    }
    if (tips != null) {
      print(tips);
       showWarnToast(tips);
      return;
    }
    send();
  }
}
