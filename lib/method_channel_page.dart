import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelPage extends StatefulWidget {
  String title;

  MethodChannelPage(this.title);

  @override
  _MethodChannelPageState createState() => _MethodChannelPageState(title);
}

class _MethodChannelPageState extends State<MethodChannelPage> {
  String title;

  _MethodChannelPageState(this.title);

  String plat = "Android";
  String recive = "";

  static const methodChannel = const MethodChannel('flutter_and_native_101');

  static Future<dynamic> invokNative(String method, {Map arguments}) async {
    if (arguments == null) {
      return await methodChannel.invokeMethod(method);
    } else {
      return await methodChannel.invokeMethod(method, arguments);
    }
  }

  Future<dynamic> nativeMessageListener() async {
    methodChannel.setMethodCallHandler((resultCall) {
      MethodCall call = resultCall;
      String method = call.method;
      Map arguments = call.arguments;

      int code = arguments["code"];
      String message = arguments["message"];
      setState(() {
        recive += " code $code message $message and method $method ";
        print(recive);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isIOS) {
      //ios相关代码
      plat = "IOS ";
    } else if (Platform.isAndroid) {
      //android相关代码
      plat = "Android";
    }

    nativeMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.blue,
      //标题居中显示
      centerTitle: true,
      //返回按钮占位
      leading: Container(),
      //标题显示
      title: Text(title),
    );
    return Scaffold(
      appBar: appBar,
      //显示的页面
      body: buildWidget(context),
    );
  }

  buildWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "接收到的消息 $recive",
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "本页面是通过 BasicMessageChannel 与原生 android ios 通信的实例",
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {
                invokNative("test")
                  ..then((result) {
                    int code = result["code"];
                    String message = result["message"];
                    setState(() {
                      recive = "invokNative 中的回调 code $code message $message ";
                    });
                  });
              },
              child: Text(
                "向" + plat.toString() + "发送消息",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {
                invokNative("test2");
              },
              child: Text(
                "向" + plat.toString() + "发送消息 多次回复 ",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {
                invokNative("test3");
              },
              child: Text(
                "打开" + plat.toString() + "页面 ",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
