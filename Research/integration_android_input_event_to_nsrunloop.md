#Integration Android input event to NSRunloop

Due to Android plaform limitation, we can't launch a complete native application. the only way to run native code is called by java.

Here is some explain of the thread mode of an objc application

### Thread 0

this thread running Java code, 


### Thread 1

this thread is the entry of native code, running NativeActivity code.

this thread will doing this work:

* first will configure objc environment
* launch main() on new thread
* then start listen input event

### Thread 2

this thread will call main(), act as a native-app's main thread.
an UIKit-based application, will start a runloop, the runloop wait event happend and update UI, a pseudo code showing the skeleton

```
	while (event = [runloop waitUntilEventHappend]) {
		[app sendEvent:event];
		[app updateUI];
	}

```

## integration android input event

we recive android input event at thread 1, and want to receive input event at thread 2, we can create a pipe, write at thrad 1, and read at thread 2.


###how to create a pipe
###how NSRunloop add a pipe source
###how to write input event to pipe
###what event data to write
###how NSRunloop handle(read) pipe


