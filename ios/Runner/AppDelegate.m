#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>
#import "TestViewController.h"

@implementation AppDelegate{
    FlutterMethodChannel* methodChannel;
    FlutterBasicMessageChannel* messageChannel;
    FlutterEventSink     eventSink;
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFuncion:) name:@"ios.to.flutter" object:nil];
    
    
    
    
    //FlutterMethodChannel 与 Flutter 之间的双向通信
    [self  methodChannelFunction];
    //FlutterBasicMessageChannel 与Flutter 之间的双向通信
    [self BasicMessageChannelFunction];
    //EventChannel 与Flutter 之间的通信
    [self EventChannelFunction];
    
    
    
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
-(void) EventChannelFunction{
     FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterEventChannel* eventChannel = [FlutterEventChannel eventChannelWithName:@"flutter_and_native_102" binaryMessenger:controller];
    [eventChannel setStreamHandler:self];
}


// // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    eventSink = events;
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"主动发送通知到flutter");
         NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"注册成功" forKey:@"message"];
        [dic setObject: [NSNumber numberWithInt:200] forKey:@"code"];
        eventSink(dic);
        
    }
    
   
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    eventSink = nil;
    return nil;
}

-(void) BasicMessageChannelFunction{
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    // 初始化定义
    messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"flutter_and_native_100" binaryMessenger:controller];
    
    // 接收消息监听
    [messageChannel setMessageHandler:^(id message, FlutterReply callback) {
        
        NSString *method=message[@"method"];
        if ([method isEqualToString:@"test"]) {
            
            NSLog(@"flutter 调用到了 ios test");
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:@"[messageChannel setMessageHandler:^(id message, FlutterReply callback)  返回给flutter的数据" forKey:@"message"];
            [dic setObject: [NSNumber numberWithInt:200] forKey:@"code"];
            
            
            callback(dic);
            
        }else  if ([method isEqualToString:@"test2"]) {
            NSLog(@"flutter 调用到了 ios test2");
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"[messageChannel sendMessage:dic] 返回给flutter的数据" forKey:@"message"];
            [dic setObject: [NSNumber numberWithInt:200] forKey:@"code"];
            [messageChannel sendMessage:dic];
        }else  if ([method isEqualToString:@"test3"]) {
            NSLog(@"flutter 调用到了 ios test3 打开一个新的页面 ");
            TestViewController *testController = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
            [controller presentViewController:testController animated:YES completion:nil];
        }
    }];
    
}

-(void) methodChannelFunction{
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    methodChannel = [FlutterMethodChannel
                     methodChannelWithName:@"flutter_and_native_101"
                     binaryMessenger:controller];
    
    [methodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        NSString *method=call.method;
        if ([method isEqualToString:@"test"]) {
            
            NSLog(@"flutter 调用到了 ios test");
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"result.success 返回给flutter的数据" forKey:@"message"];
            [dic setObject: [NSNumber numberWithInt:200] forKey:@"code"];
    
            result(dic);
            
        }else  if ([method isEqualToString:@"test2"]) {
            NSLog(@"flutter 调用到了 ios test2");
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"result.success 返回给flutter的数据" forKey:@"message"];
            [dic setObject: [NSNumber numberWithInt:200] forKey:@"code"];
            [methodChannel invokeMethod:@"test" arguments:dic];
        }else  if ([method isEqualToString:@"test3"]) {
            NSLog(@"flutter 调用到了 ios test3 打开一个新的页面 ");
            TestViewController *testController = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
            [controller presentViewController:testController animated:YES completion:nil];
        }
        
    }];
    
    
}


- (void)notificationFuncion: (NSNotification *) notification {
    //处理消息
    NSLog(@"notificationFuncion ");
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (methodChannel!=nil) {
        [dic setObject:@"methodChannel invokeMethod 向Flutter 发送消息 " forKey:@"message"];
        [dic setObject: [NSNumber numberWithInt:400] forKey:@"code"];
        [methodChannel invokeMethod:@"test" arguments:dic];
    }
    if (messageChannel!=nil) {
        [dic setObject:@" [messageChannel sendMessage:dic]; 向Flutter 发送消息 " forKey:@"message"];
        [dic setObject: [NSNumber numberWithInt:401] forKey:@"code"];
        [messageChannel sendMessage:dic];
    }
    
}

- (void)dealloc {
    //单条移除观察者
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"REFRESH_TABLEVIEW" object:nil];
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
