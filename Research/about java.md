#JAVA 

## HOW to call java methods

### get java method signature


	javap -classpath path/to/sdk/android.jar -s javaclassname```
	
example:
	
	javap -classpath platforms/android-19/android.jar -s android.webkit.WebView
	
	javap -classpath bin/classes/path/to/custom/ -s org.tiny4.custom
	
### custom root class
### custom subclass