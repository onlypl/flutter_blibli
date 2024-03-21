import 'package:flutter/material.dart';

//排行榜
class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: const Text('排行榜'),
        ),
    );
  }
}