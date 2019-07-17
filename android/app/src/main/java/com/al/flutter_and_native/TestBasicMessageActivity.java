package com.al.flutter_and_native;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;

public class TestBasicMessageActivity extends FlutterActivity {
	
	
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
		
		
		Intent lIntent = new Intent("android.to.flutter");
		sendBroadcast(lIntent);
	}
}
