# Flutter-Android-iOS

Flutter 与 Android iOs 的双向通信 demo

[更多文章请查看 flutter从入门 到精通](https://blog.csdn.net/zl18603543572/article/details/93532582)

[本文章中的完整代码在这里](https://github.com/zhaolongs/Flutter-Android-iOS)

题记：不到最后时刻，千万别轻言放弃，无论结局成功与否，只要你拼博过，尽力过，一切问心无愧。

***
Flutter 与 Android iOS 原生的通信有以下三种方式 
* BasicMessageChannel 实现 Flutter 与 原生(Android 、iOS)双向通信
* MethodChannel 实现 Flutter 与 原生原生(Android 、iOS)双向通信
* EventChannel 实现 原生原生(Android 、iOS)向Flutter 发送消息
***

demo 将实现：（通过 BasicMessageChannel、MethodChannel）

* 实现 Flutter 调用 Android 、iOS 原生的方法并回调Flutter
* 实现 Flutter 调用 Android 、iOS 原生并打开Android 原生的一个Activity页面,iOS原生的一个ViewController 页面
* 实现 Android 、iOS 原生主动发送消息到 Flutter 中
* 实现  Android 、iOS 原生中的 TestActivity 页面主动发送消息到Flutter中

Android 中的效果

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190717153015164.gif)

ios 中的效果

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190717153317579.gif)
