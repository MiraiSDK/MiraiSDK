package org.tiny4.CocoaActivity;

import android.os.Bundle;
import android.app.Activity;
import android.app.NativeActivity;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;

import android.util.Log;

public class CocoaActivity extends NativeActivity
{

    public native int nativeSupportedOrientation(int orientation);

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
}
