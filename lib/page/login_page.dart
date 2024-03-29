// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';
import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/dao/login_dao.dart';
import 'package:blibli/util/string_util.dart';
import 'package:blibli/util/toast.dart';
import 'package:blibli/widget/appbar.dart';
import 'package:blibli/widget/login_button.dart';
import 'package:blibli/widget/login_effect.dart';
import 'package:blibli/widget/login_input.dart';

import '../util/log.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  late String userName;
  late String password;
  bool loginEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('登录', '注册', () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }),
      body: Container(
        child: ListView(
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
              lineStretch: true,
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(title: "登录",enable: loginEnable, onPressed: (){send();}),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }


  void send() async {
    try {
      var result = await LoginDao.login(userName, password);
      if (result["code"] == 0) {
        Log().info('登录成功');
        showToast('登录成功');
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        Log().info(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedLogin catch (e) {

       showWarnToast(e.message);
    } on NeedAuth catch (e) {
        showWarnToast(e.message);
    }
  }
}
