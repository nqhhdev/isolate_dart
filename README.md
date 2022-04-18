# flutter_isolate

An isolated Dart execution context.

All Dart code runs in an isolate, and code can access classes and values only from the same isolate. Different isolates can communicate by sending values through ports (see ReceivePort, SendPort).

An Isolate object is a reference to an isolate, usually different from the current isolate. It represents, and can be used to control, the other isolate.

When spawning a new isolate, the spawning isolate receives an Isolate object representing the new isolate when the spawn operation succeeds.

Isolates run code in its own event loop, and each event may run smaller tasks in a nested microtask queue.

An Isolate object allows other isolates to control the event loop of the isolate that it represents, and to inspect the isolate, for example by pausing the isolate or by getting events when the isolate has an uncaught error.

The controlPort identifies and gives access to controlling the isolate, and the pauseCapability and terminateCapability guard access to some control operations. For example, calling pause on an Isolate object created without a pauseCapability, has no effect.

The Isolate object provided by a spawn operation will have the control port and capabilities needed to control the isolate. New isolate objects can be created without some of these capabilities if necessary, using the Isolate.Isolate constructor.

An Isolate object cannot be sent over a SendPort, but the control port and capabilities can be sent, and can be used to create a new functioning Isolate object in the receiving port's isolate.

Demo Isolate and work follow

[](../../../../q/Untitled-Diagram.drawio-1.png)