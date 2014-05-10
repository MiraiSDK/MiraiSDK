package org.tiny4.NextBookRun;
import android.os.Bundle;
import android.app.Activity;
import android.app.NativeActivity;

import android.widget.RelativeLayout;

public class MainHActivity extends NativeActivity
{
    static
    {
        System.loadLibrary ("gnustl_shared");
        System.loadLibrary ("dispatch");
        System.loadLibrary ("objc");
        System.loadLibrary ("gnustep-base");
        System.loadLibrary ("gnustep-corebase");
        System.loadLibrary ("CoreGraphics");
        System.loadLibrary ("CoreText");
        System.loadLibrary ("GLESv2");
        System.loadLibrary ("OpenGLES");
        System.loadLibrary ("QuartzCore");
        System.loadLibrary ("UIKit");
        System.loadLibrary ("NextBookKit");
        System.loadLibrary ("NextBookRun");

    }
    
    @Override
    public void onCreate (Bundle savedInstanceState)
    {
        super.onCreate (savedInstanceState);
        //nativeOnCreate();
    }
    
    //private native void nativeOnCreate();

    
}



