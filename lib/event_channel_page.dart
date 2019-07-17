import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelPage extends StatefulWidget {
  String title;

  EventChannelPage(this.title);

  @override
  _EventChannelPageState createState() => _EventChannelPageState(title);
}

class _EventChannelPageState extends State<EventChannelPage> {
  String title;

  _EventChannelPageState(this.title);

  String plat = "Android";
  String recive = "";

//EventChannel（ 用于数据流（event streams）的通信）
  static const EventChannel _eventChannel =
      const EventChannel('flutter_and_native_102');

  Future<dynamic> nativeMessageListener() async {
    _eventChannel.receiveBroadcastStream().listen((arguments) {
      int code = arguments["code"];
      String message = arguments["message"];
      setState(() {
        recive +=
            " code $code message $message  ";
        print(recive);
      });
    }, onError: (event) {});


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
            "本页面是通过 EventChannel 与原生 android ios 通信的实例",
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {},
              child: Text(
                "向" + plat.toString() + "发送消息",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {},
              child: Text(
                "向" + plat.toString() + "发送消息 多次回复 ",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {},
              child: Text(
                "打开" + plat.toString() + "页面 ",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
