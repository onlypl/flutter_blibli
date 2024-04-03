import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/provider/theme_provider.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModelItem extends StatelessWidget {
  const DarkModelItem({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    Color titleColor = HiColor().themeColor(
        themeProvider.isDark(context), Colors.white70, Colors.black87);
   IconData icon = themeProvider.isDark(context)?Icons.nightlight_round:Icons.wb_sunny_rounded;
    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.darkModel);
      },
      child: Container(
         padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
        child: Row(
          children: [
            Text(
              '夜间模式',
              style: TextStyle(
                color: titleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding:const EdgeInsets.only(top: 2,left: 10),
              child:Icon(icon,color: titleColor),
            ),
            
          ],
        ),
      ),
    );
  }
}
