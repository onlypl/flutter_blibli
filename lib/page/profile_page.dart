import 'package:flutter/material.dart';
//我的
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: const Text('我的'),
        ),
    );
  }
}