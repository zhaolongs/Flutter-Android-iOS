import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_message_channel_page.dart';
import 'event_channel_page.dart';
import 'method_channel_page.dart';

class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage(this.title);

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  String title;

  _MyHomePageState(this.title);

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
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    new CupertinoPageRoute<void>(
                        builder: (ctx) =>
                            BasicMessageChannelPage("BasicMessageChannel 实现 Flutter 与 原生双向通信")));
              },
              child: Text(
                "BasicMessageChannel 通信",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    new CupertinoPageRoute<void>(
                        builder: (ctx) =>
                            MethodChannelPage("MethodChannel 实现 Flutter 与 原生双向通信")));
              },
              child: Text(
                "MethodChannel 通信",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: FlatButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                    context,
                    new CupertinoPageRoute<void>(
                        builder: (ctx) =>
                            EventChannelPage("EventChannel 实现 原生向Flutter 发送消息")));
              },
              child: Text(
                "EventChannel 通信",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
