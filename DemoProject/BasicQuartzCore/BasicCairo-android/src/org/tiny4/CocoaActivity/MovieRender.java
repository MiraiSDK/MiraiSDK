package org.tiny4.CocoaActivity;

import android.graphics.SurfaceTexture;
import android.media.MediaPlayer;
import android.view.Surface;
import android.opengl.Matrix;
import java.io.IOException;
import java.util.Arrays;

import android.util.Log;

public class MovieRender
implements SurfaceTexture.OnFrameAvailableListener, MediaPlayer.OnErrorListener {
	
	private static final String TAG = "MovieRender";
	
    private MediaPlayer mMediaPlayer;
	private int mTexID;
	private boolean needsUpdateSurface = false;
    private SurfaceTexture mSurface;
    private float[] mSTMatrix = new float[16];
	
	
	public MovieRender (MediaPlayer player, int texID) {	
		Log.i(TAG, "MediaPlayer create");
		
        mMediaPlayer = player;
		mTexID = texID;
		
		player.setOnErrorListener(this);
			
		mSurface = new  SurfaceTexture(texID);
		mSurface.setOnFrameAvailableListener(this);
		
        Surface surface = new Surface(mSurface);
        player.setSurface(surface);
        surface.release();
			
        Matrix.setIdentityM(mSTMatrix, 0);	
	}
 
    synchronized public void onFrameAvailable(SurfaceTexture surface) {
        //Log.i(TAG, "onFrameAvailable");
		
        needsUpdateSurface = true;
    }
 
 	public boolean onError(MediaPlayer mp, int what, int extra) {
		Log.i(TAG, "MediaPlayer onError: " + what + "extra:" + extra);
        return  true;
	}
	
    public int updateTextureIfNeeds (float [] matrix) {
        //Log.i(TAG, "updateTextureIfNeeds");
        synchronized (this) {
	        //Log.i(TAG, "check needsUpdateSurface");
            if (needsUpdateSurface) {
		        //Log.i(TAG, "will mSurface.updateTexImage()");
                mSurface.updateTexImage();
                mSurface.getTransformMatrix(matrix);
				
                needsUpdateSurface = false;
				
				return 1;
            }
        }
		return 0;
	}
	public void start() {
        Log.i(TAG, "in Java, will call MediaPlayer start");
		
		try {
			mMediaPlayer.prepare();
		} catch (IllegalStateException e) {
            Log.i(TAG, "MediaPlayer prepare exception: " + e.getMessage());
        }  catch (IOException e) {
            Log.i(TAG, "MediaPlayer prepare IOException: " + e.getMessage());
        }
		
		try {
			mMediaPlayer.start();
		} catch (IllegalStateException e) {
            Log.i(TAG, "MediaPlayer start exception: " + e.getMessage());
        }
	}
}
