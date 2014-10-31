package org.tiny4.CocoaActivity;

import android.app.Activity;
import android.content.Context;
import android.graphics.Matrix;
import android.graphics.SurfaceTexture;
import android.graphics.drawable.ColorDrawable;
import android.os.Looper;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.PopupWindow;

/**
 * Created by Yonghui Chen on 10/31/14.
 */

public class GLViewRender extends Object implements SurfaceTexture.OnFrameAvailableListener {
    private static final String TAG = "GLViewRender";
    private final Activity mActivity;
    private View mTarget;
    private PopupWindow _popUp;

    private int mWidth;
    private int mHeight;
    private final int _glTexId;

    private Surface mSurface = null;
    private SurfaceTexture surfaceTexture = null;

    private boolean isTargetDirty = true;
    private boolean needsUpdateSurface = false;

    public GLViewRender(Context context, int glTexID, int width, int height) {
        super();

        _glTexId = glTexID;
        mActivity = (Activity)context;

        setSize(width,height);

        createTargetViewOnUiThread();
    }

    public Surface getSurface() {
        return mSurface;
    }

    protected View onCreateTargetView(Activity activity) {
        return new View(activity);
    }

    public View getTargetView() {
        return mTarget;
    }

    public void onDestory() {
        Log.i(TAG, "onDestory");

        _popUp.dismiss();
    }

    private void recreateSurface()
    {
        mSurface = null;
        surfaceTexture = null;

        if (_glTexId > 0) {
            surfaceTexture = new SurfaceTexture(_glTexId);
            surfaceTexture.setDefaultBufferSize(mWidth,mHeight);
            surfaceTexture.setOnFrameAvailableListener(this);
            mSurface = new Surface(surfaceTexture);
        }
    }

    synchronized public void onFrameAvailable(SurfaceTexture surface) {
        needsUpdateSurface = true;
    }

    public void setSize(final int width, final int height) {

        mWidth = width;
        mHeight = height;

        recreateSurface();

        if (_popUp != null) {
            Runnable aRunnable = new Runnable() {
                @Override
                public void run() {
                    ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(width,height);
                    _popUp.getContentView().setLayoutParams(params);
                    
                    synchronized (this) {
                        this.notify() ;
                    }
                }
            };
            
            runOnUiThreadAndWait(aRunnable);
        }
    }

    protected void runOnUiThreadAndWait(Runnable aRunnable) {
        if (Looper.myLooper() == Looper.getMainLooper()) {
            throw new IllegalStateException("This method should only be called off the Android UI thread");
        }

        synchronized (aRunnable) {
            mActivity.runOnUiThread(aRunnable);

            try {
                aRunnable.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public int updateTextureIfNeeds(float [] matrix) {
        //Log.i(TAG,"updateTextureIfNeeds");

        synchronized (this) {
            if (needsUpdateSurface) {
                surfaceTexture.updateTexImage();
                surfaceTexture.getTransformMatrix(matrix);

                needsUpdateSurface = false;

                return 1;
            }
        }

        return 0;
    }

    public void setTargetViewDirty() {
        isTargetDirty = true;
    }

    private void createTargetViewOnUiThread() {

        Runnable aRunnable = new Runnable() {
            @Override
            public void run() {
                View target = onCreateTargetView(mActivity);
                mTarget = target;

                _popUp = new PopupWindow(mActivity);

                _popUp.setWindowLayoutMode(ViewGroup.LayoutParams.WRAP_CONTENT,ViewGroup.LayoutParams.WRAP_CONTENT);
                _popUp.setClippingEnabled(true);
                _popUp.setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
                _popUp.setTouchable(false);

                LinearLayout layout = new LinearLayout(mActivity);
                LinearLayout mainLayout = new LinearLayout(mActivity);

                ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(mWidth,mHeight);

                layout.setOrientation(LinearLayout.VERTICAL);
                layout.addView(target,params);

                _popUp.setContentView(layout);

                _popUp.showAtLocation(mainLayout, Gravity.BOTTOM,0,0);
                _popUp.update();

                synchronized (this) {
                    this.notify() ;
                }

            }
        };

        runOnUiThreadAndWait(aRunnable);
    }

    public void simulateTouch(long eventTime, long downTime, int action, long x, long y) {
        int location[] = {0,0};
        mTarget.getLocationOnScreen(location);

        float fx = x + location[0];
        float fy = y + location[1];

        int metaState = 0;
        final MotionEvent event = MotionEvent.obtain(downTime,
                eventTime,
                action,
                fx,
                fy,
                metaState);
        Matrix m = new Matrix();
        m.setTranslate(-location[0],-location[1]);
        event.transform(m);

        dispatchEvent(event);
    }

    public void dispatchEvent(android.view.MotionEvent event) {
        final MotionEvent aEvent = event;
        Runnable aRunnable = new Runnable() {
            @Override
            public void run() {
                mTarget.dispatchTouchEvent(aEvent);
            }
        };

        mActivity.runOnUiThread(aRunnable);
    }
}
