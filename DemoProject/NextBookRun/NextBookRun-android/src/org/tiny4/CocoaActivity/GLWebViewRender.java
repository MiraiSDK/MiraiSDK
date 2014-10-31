package org.tiny4.CocoaActivity;

/**
 * Created by Yonghui Chen on 10/31/14.
 */
import android.app.Activity;
import android.content.Context;
import android.view.View;

public class GLWebViewRender extends GLViewRender {
    private GLWebView _webview;
    public GLWebViewRender(Context context, int glTexID, int width, int height) {
        super(context,glTexID,width,height);
    }

    @Override
    protected View onCreateTargetView(Activity activity) {
        GLWebView wb = new GLWebView(activity);
        wb.setRender(this);
        _webview = wb;
        return wb;
    }

    public void loadUrl(final java.lang.String url) {
        Runnable aRunnable = new Runnable() {
            @Override
            public void run() {
                _webview.loadUrl(url);

                synchronized (this) {
                    this.notify() ;
                }
            }
        };

        runOnUiThreadAndWait(aRunnable);
    }

    public void loadDataWithBaseURL(java.lang.String baseUrl, java.lang.String data, java.lang.String mimeType, java.lang.String encoding, java.lang.String historyUrl) {
        final String aData = data;
        final String aMimeType = mimeType;
        final String aEncoding = encoding;
        final String aBaseUrl = baseUrl;
        final String aHistoryUrl = historyUrl;

        Runnable aRunnable = new Runnable() {
            @Override
            public void run() {
                _webview.loadDataWithBaseURL(aBaseUrl,aData,aMimeType,aEncoding,aHistoryUrl);

                synchronized (this) {
                    this.notify() ;
                }
            }
        };

        runOnUiThreadAndWait(aRunnable);
    }

    public void loadData(final java.lang.String data, final java.lang.String mimeType, final java.lang.String encoding) {

        Runnable aRunnable = new Runnable() {
            @Override
            public void run() {
                _webview.loadData(data,mimeType,encoding);

                synchronized (this) {
                    this.notify() ;
                }
            }
        };

        runOnUiThreadAndWait(aRunnable);
    }

}
