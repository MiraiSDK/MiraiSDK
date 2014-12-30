package org.tiny4.CocoaActivity;

import android.os.Bundle;
import android.app.Activity;
import android.app.NativeActivity;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;

import android.util.Log;

public class CocoaActivity extends NativeActivity
{
    private static String TAG = "CocoaActivity";
    
    public native int nativeSupportedOrientation(int orientation);

    private native void nativeOnTrimMemory(int level);
    
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
    }
    public void onConfigurationChanged (Configuration newConfig)
    {
        super.onConfigurationChanged (newConfig);
    }

    public void updateSupportedOrientation (int orientation)
    {
        // called from native while supportedInterfaceOrientations changed
        int currentOrientation = this.getRequestedOrientation();
        if (currentOrientation != orientation) {
            this.setRequestedOrientation(orientation);
        }
    }
    
    public void onTrimMemory (int level)
    {
        Log.i(TAG,"onTrimMemory:"+ level);
        nativeOnTrimMemory(level);
    }
}
