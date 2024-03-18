import 'package:blibli/db/hi_cache.dart';
import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/core/hi_net.dart';
import 'package:blibli/http/dao/login_dao.dart';
import 'package:blibli/http/request/test_request.dart';
import 'package:blibli/page/login_page.dart';
import 'package:blibli/page/registration_page.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HiCache.preInit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:primary,//主题色
          ).copyWith(
            secondary: Colors.white //次要颜色
          ),
        //   ColorScheme.fromSwatch(
        //   primarySwatch: white
        // ).copyWith(
        //   secondary: Colors.green //次要颜色
        // ),
        //useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: white //
        ),
      ),
      //home: const RegistrationPage(),
       home: const LoginPage(),
      //home: const MyHomePage(title: '12312',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    // TestRequest request = TestRequest();
    // request.add("aa", "bb").add("ccc", "ddd").add('requestPrams', "1");
    // try {
    //   var result = await HiNet.getInstance().fire(request);
    //    print(result); 
    // } on NeedAuth catch (e) {
    //   print(e); 
    // } on NeedLogin catch (e){
    //     print(e); 
    // }catch(e){
    //     print(e); 
    // }

      testLogin();
    setState(() {
      _counter++;
    });
 
  }
  //     var result = await LoginDao.login('test', '123456');
 void testLogin() async{
  // try {
  //     var result = await LoginDao.login('test', '123456');
  //  print(result); 
  // }on NeedAuth catch (e) {
  //   print(e);
  // } on NeedLogin catch (e){
  //   print(e);
  // }catch (e) {
  //   print('111111'+e.toString()); 
  // }
 }
 void testNotice() async{

 }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
