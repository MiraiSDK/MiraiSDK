package org.tiny4.Basic;
import android.os.Bundle;
import android.app.Activity;

import android.widget.RelativeLayout;

public class MainHActivity extends Activity
{
    static
    {
        System.loadLibrary ("gnustl_shared");
        System.loadLibrary ("dispatch");
        System.loadLibrary ("objc");
        System.loadLibrary ("gnustep-base");
        System.loadLibrary ("Basic");
    }

    @Override
    public void onCreate (Bundle savedInstanceState)
    {
        super.onCreate (savedInstanceState);
        nativeOnCreate();
    }
    
    private native void nativeOnCreate();
}


