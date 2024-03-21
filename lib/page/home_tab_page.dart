// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/model/home_mo.dart';
import 'package:flutter/material.dart';

class HomTabPage extends StatefulWidget {
  final String? name;
   final List<BannerMo>? bannerList;
  const HomTabPage({
    super.key,
    this.name, this.bannerList,
  });

  @override
  State<HomTabPage> createState() => _HomTabPageState();
}

class _HomTabPageState extends State<HomTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name ?? ''),
    );
  }
}