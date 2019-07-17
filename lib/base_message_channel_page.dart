import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicMessageChannelPage extends StatefulWidget {
  String title;

  BasicMessageChannelPage(this.title);

  @override
  _BasicMessageChannelPage createState() => _BasicMessageChannelPage(title);
}

class _BasicMessageChannelPage extends State<BasicMessageChannelPage> {
  String title;

  _BasicMessageChannelPage(this.title);

  String plat = "Android";
  String recive="暂无";
  static const messageChannel = const BasicMessageChannel('flutter_and_native_100', StandardMessageCodec());


  //发送消息
  Future<Map> sendMessage(Map json) async {

    Map reply = await messageChannel.send(json);

    //解析 原生发给 Flutter 的参数
    int code = reply["code"];
    String message=reply["message"];

    setState(() {
      recive="code:$code message:$message";
    });
    return reply;
  }



  //接收消息监听
  void receiveMessage() {
    messageChannel.setMessageHandler((result) async {

      //解析 原生发给 Flutter 的参数
      int code = result["code"];
      String message=result["message"];

      setState(() {
        recive="receiveMessage: code:$code message:$message";
      });
      return 'Flutter 已收到消息';
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

    receiveMessage();
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
//                sendMessage("{'method':'test','ontent':'flutter 中的数据','code':100}");
                sendMessage({"method":"test","ontent":"flutter 中的数据","code":100});
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
                sendMessage({"method":"test2","ontent":"flutter 中的数据","code":100});
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
                sendMessage({"method":"test3","ontent":"flutter 中的数据","code":100});
              },
              child: Text(
                "打开" + plat.toString() + "原生页面",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
