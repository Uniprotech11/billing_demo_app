import android.os.Bundle;
import android.content.ComponentName
import android.content.Intent
import android.net.Uri
package com.example.billing_demo_app
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import kotlin.Int

class MainActivity: FlutterActivity() {    
    private static final String CHANNEL = "com.lululalait.kiosk";
    @Override
    protected void onCreate(Bundle savedInstanceState)
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(),CHANNEL.setMethodCallHandler(
                   new MethodChannel.MethodCallHandler()
                   @Override
                   public void onMethodCall(MethodCall call,MethodChannel.Result result)
                         Log.d("MethodName", call.method);
                            if(call.method.equals("sendData"))                      
                                                       
                                  Map<String,Object> data=(Map<String,Object>)call.arguments;
                                     String type=data.get("type");
                                     String action=data.get("action");
                                     String date=data.get("date");
                                     String time=data.get("time");
                                     String bill_id=data.get("bill_id");
                                     String amount=data.get("amount");                     
                                                             
                                     val compName = ComponentName(
                                            "com.lululalait.kiosk",
                                            "com.lululalait.kiosk.KioskActivity"
                                        )
                                        val intent = Intent(
                                            Intent.ACTION_MAIN,
                                            Uri.parse("sales://")
                                        ).apply {
                                            flags = Intent.FLAG_ACTIVITY_NEW_TASK
                                            addCategory(Intent.CATEGORY_LAUNCHER)
                                            component = compName
                                            addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION)
                                        }
                                        
                                        // val intent = Intent(
                                        //     Intent.ACTION_MAIN,
                                        //     Uri.parse("sales://")
                                        // ).apply {
                                        //     flags = Intent.FLAG_ACTIVITY_NEW_TASK
                                        //     addCategory(Intent.CATEGORY_LAUNCHER)
                                        //     component = compName
                                        //     putExtra("Request",  < Request serialized string >  )
                                        //     addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION)
                                        // }
                                                   

                                            ))
        
}



    
    
   
   





