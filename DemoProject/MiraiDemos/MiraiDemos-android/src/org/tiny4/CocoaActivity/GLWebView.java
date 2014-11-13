package org.tiny4.CocoaActivity;

import android.content.Context;
import android.graphics.Canvas;

import android.view.Surface;

import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings;

/**
 * Created by Yonghui Chen on 10/23/14.
 */
public class GLWebView extends WebView {
    private GLViewRender mRender;

    public  GLWebView(Context context) {
        super(context);

        setWebChromeClient(new WebChromeClient(){});
        setWebViewClient(new WebViewClient());

        setHorizontalScrollBarEnabled(false);
        setVerticalScrollBarEnabled(false);
        
        WebSettings s = getSettings();
        s.setJavaScriptEnabled(true);
        s.setDomStorageEnabled(true);
        //s.setBuiltInZoomControls(true);
    }

    public void setRender(GLViewRender r) {
        mRender = r;
    }

    @Override protected  void onDraw (Canvas canvas) {
        Surface mSurface = mRender.getSurface();

        if (mSurface != null) {

            try {
                final Canvas surfaceCanvas = mSurface.lockCanvas(null);
                surfaceCanvas.translate(-getScrollX(),-getScrollY());
                super.onDraw(surfaceCanvas);
                mSurface.unlockCanvasAndPost(surfaceCanvas);
            } catch (Surface.OutOfResourcesException excp) {
                excp.printStackTrace();
            }

        }

        //super.onDraw(canvas);
    }

    @Override
    public void invalidate() {
        super.invalidate();

        mRender.setTargetViewDirty();
    }
}
