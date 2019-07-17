package com.al.flutter_and_native;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

/**
 * Flutter提供三种platform和dart端的消息通信方式BasicMessageChannel，MethodChannel，EventChannel
 * 这三种通信都是全双工通信，即A-->B且B-->A，dart可以主动发送消息给platform端，并接收到platform端处理后的返回数据，
 * 同样，platform端可以主动发送消息给dart端，dart端接收数据处理后返回给platform端
 * <p>
 * BasicMessageChannel （主要是传递字符串和一些半结构体的数据）
 */
public class MainActivity extends FlutterActivity {
	
	private static final String CHANNEL = "samples.flutter.io/battery";
	public static BinaryMessenger flutterView;
	private Context mContext;
	private BasicMessageChannel<Object> mMessageChannel;
	
	Handler mHandler = new Handler(Looper.myLooper());
	private MyReceiver mMyReceiver;
	private MethodChannel mMethodChannel;
	private EventChannel.EventSink mEventSink;
	
	@Override
	protected void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mMyReceiver);
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		GeneratedPluginRegistrant.registerWith(this);
		
		flutterView = getFlutterView();
		mContext = this;
		//BasicMessageChannel 通信方式
		messageChannelFunction();
		//MethodChannel 通信方式
		methodChannelFunction();
		//EventChannel 通信方式
		eventChannelFunction();
		
		mMyReceiver = new MyReceiver();
		IntentFilter lIntentFilter = new IntentFilter("android.to.flutter");
		registerReceiver(mMyReceiver, lIntentFilter);
		
		
		
	}
	private void  eventChannelFunction(){
		EventChannel lEventChannel = new EventChannel(getFlutterView(), "flutter_and_native_102");
		lEventChannel.setStreamHandler(
				new EventChannel.StreamHandler() {
					@Override
					public void onListen(Object o, EventChannel.EventSink eventSink) {
						mEventSink = eventSink;
						mHandler.post(new Runnable() {
							@Override
							public void run() {
								Map<String, Object> resultMap = new HashMap<>();
								resultMap.put("message", "注册成功");
								resultMap.put("code", 200);
								eventSink.success(resultMap);
							}
							
						});
					}
					
					@Override
					public void onCancel(Object o) {
					
					}
					
					
				}
		);
	}
	private void methodChannelFunction() {
		mMethodChannel = new MethodChannel(getFlutterView(), "flutter_and_native_101");
		//设置监听
		mMethodChannel.setMethodCallHandler(
				new MethodChannel.MethodCallHandler() {
					@Override
					public void onMethodCall(MethodCall call, MethodChannel.Result result) {
						String lMethod = call.method;
						// TODO
						if (lMethod.equals("test")) {
							Toast.makeText(mContext, "flutter 调用到了 android test", Toast.LENGTH_SHORT).show();
							Map<String, Object> resultMap = new HashMap<>();
							resultMap.put("message", "result.success 返回给flutter的数据");
							resultMap.put("code", 200);
							result.success(resultMap);
							
						} else if (lMethod.equals("test2")) {
							Toast.makeText(mContext, "flutter 调用到了 android test2", Toast.LENGTH_SHORT).show();
							Map<String, Object> resultMap = new HashMap<>();
							resultMap.put("message", "android 主动调用 flutter test 方法");
							resultMap.put("code", 200);
							mMethodChannel.invokeMethod("test", resultMap);
							
							mHandler.postDelayed(new Runnable() {
								@Override
								public void run() {
									Map<String, Object> resultMap2 = new HashMap<>();
									resultMap2.put("message", "android 主动调用 flutter test 方法");
									resultMap2.put("code", 200);
									mMethodChannel.invokeMethod("test2", resultMap2);
								}
							}, 2000);
							
							
						} else if (lMethod.equals("test3")) {
							//测试通过Flutter打开Android Activity
							Toast.makeText(mContext, "flutter 调用到了 android test3", Toast.LENGTH_SHORT).show();
							Intent lIntent = new Intent(MainActivity.this, TestMethodChannelActivity.class);
							MainActivity.this.startActivity(lIntent);
						} else {
							
							
							result.notImplemented();
						}
					}
				}
		);
	}
	
	private void messageChannelFunction() {
		//消息接收监听
		//BasicMessageChannel （主要是传递字符串和一些半结构体的数据）
		mMessageChannel = new BasicMessageChannel<Object>(getFlutterView(), "flutter_and_native_100", StandardMessageCodec.INSTANCE);
		// 接收消息监听
		mMessageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() {
			@Override
			public void onMessage(Object o, BasicMessageChannel.Reply<Object> reply) {
				
				System.out.println("onMessage: " + o.toString());
				JSONObject lJSONObject = null;
				try {
					//解析Flutter 传递的参数
					lJSONObject = new JSONObject(o.toString());
					//方法名标识
					String lMethod = lJSONObject.getString("method");
					//测试 reply.reply()方法 发消息给Flutter
					if (lMethod.equals("test")) {
						Toast.makeText(mContext, "flutter 调用到了 android test", Toast.LENGTH_SHORT).show();
						Map<String, Object> resultMap = new HashMap<>();
						resultMap.put("message", "reply.reply 返回给flutter的数据");
						resultMap.put("code", 200);
						reply.reply(resultMap);
						
					} else if (lMethod.equals("test2")) {
						//测试 mMessageChannel.send 发消息给Flutter
						channelSendMessage();
					} else if (lMethod.equals("test3")) {
						//测试通过Flutter打开Android Activity
						Toast.makeText(mContext, "flutter 调用到了 android test3", Toast.LENGTH_SHORT).show();
						Intent lIntent = new Intent(MainActivity.this, TestBasicMessageActivity.class);
						MainActivity.this.startActivity(lIntent);
					}
					
					
				} catch (JSONException e) {
					e.printStackTrace();
				}
				
				
			}
		});
		
		
	}
	
	private void channelSendMessage() {
		
		Toast.makeText(mContext, "flutter 调用到了 android test", Toast.LENGTH_SHORT).show();
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("message", "reply.reply 返回给flutter的数据");
		resultMap.put("code", 200);
		
		mMessageChannel.send(resultMap, new BasicMessageChannel.Reply<Object>() {
			@Override
			public void reply(Object o) {
				
				Log.d("mMessageChannel", "mMessageChannel send 回调 " + o);
			}
		});
	}
	
	
	public class MyReceiver extends BroadcastReceiver {
		public MyReceiver() {
		}
		
		@Override
		public void onReceive(Context context, Intent intent) {
			Toast.makeText(context, "接收到自定义的广播", Toast.LENGTH_SHORT).show();
			mHandler.post(new Runnable() {
				@Override
				public void run() {
					Map<String, Object> resultMap2 = new HashMap<>();
					resultMap2.put("message", "android 主动调用 flutter test 方法");
					resultMap2.put("code", 200);
					
					if (mMessageChannel != null) {
						// 向Flutter 发送消息
						mMessageChannel.send(resultMap2, new BasicMessageChannel.Reply<Object>() {
							@Override
							public void reply(Object o) {
								System.out.println("android onReply: " + o);
							}
						});
					}
					
					
					if (mMethodChannel != null) {
						//向Flutter 发送消息
						mMethodChannel.invokeMethod("test2", resultMap2);
					}
					if (mEventSink != null) {
						mEventSink.success(resultMap2);
					}
				}
			});
		}
	}
}
