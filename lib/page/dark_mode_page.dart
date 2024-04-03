import 'package:blibli/provider/theme_provider.dart';
import 'package:hi_base/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///夜间模式页面
class DarkModelPage extends StatefulWidget {
  const DarkModelPage({super.key});

  @override
  State<DarkModelPage> createState() => _DarkModelPageState();
}

class _DarkModelPageState extends State<DarkModelPage> {
  static const _items = [
    {"name": '跟随系统', "mode": ThemeMode.system},
    {"name": '开启', "mode": ThemeMode.dark},
    {"name": '关闭', "mode": ThemeMode.light},
  ];
 var _currentTheme;
  @override
  void initState() {
    super.initState();
    var themeMode = context.read<ThemeProvider>().getThemeMode();
    for (var element in _items) {
      if (element['mode'] == themeMode) {
        _currentTheme = element;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     var themeProvider = context.read<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:themeProvider.isDark(context)?HiColor.darkBg:HiColor.bg,
        title: const Text('夜间模式'),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: primary,),
          itemCount: _items.length),
    );
  }

  Widget _item(int index) {
    Map theme = _items[index];
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding:const EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${theme['name']}',
              ),
            ),
            Opacity(
              opacity: (_currentTheme == theme)? 1 : 0,
              child:const Icon(Icons.done,color: primary, size: 24,),
            ),
          ],
        ),
      ),
    );
  }
  
  void _switchTheme(int index) {
    var theme = _items[index];
    context.read<ThemeProvider>().setTheme((theme['mode'] as ThemeMode));
    setState(() {
      _currentTheme = theme;
    });
  }
}
