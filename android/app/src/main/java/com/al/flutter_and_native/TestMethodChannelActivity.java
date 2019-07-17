package com.al.flutter_and_native;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;

public class TestMethodChannelActivity extends FlutterActivity {
	
	
	
	
	@Override
	protected void onCreate( Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_test_layout);
		TextView testTextView = findViewById(R.id.tv_test);
		testTextView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				sendFlutterMessage();
			}
		});
	}
	
	private void sendFlutterMessage() {
		
	
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("message", "android 主动调用 flutter test 方法");
		resultMap.put("code", 200);
		
		Intent lIntent = new Intent("android.to.flutter");
		sendBroadcast(lIntent);
		
	}
}
