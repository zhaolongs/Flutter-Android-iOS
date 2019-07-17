package com.al.flutter_and_native.utils;

import android.content.Context;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;

/**
 *
 */
public class FlutterNativeBasicMessageUtil {
	
	private Context mContext;
	private BasicMessageChannel<Object> mMessageChannel;
	
	public FlutterNativeBasicMessageUtil(Context context) {
		mContext = context;
		//消息接收监听
		//BasicMessageChannel （主要是传递字符串和一些半结构体的数据）
		//mMessageChannel = new BasicMessageChannel<Object>(getFlutterView(), "samples.flutter.io/message", StandardMessageCodec.INSTANCE);
		
	}
}
