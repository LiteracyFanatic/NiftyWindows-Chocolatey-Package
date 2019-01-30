# Chocolatey Package for NiftyWindows

This is a [chocolatey](https://chocolatey.org/) package to easily install the
[NiftyWindows](http://www.enovatic.org/products/niftywindows/introduction/)
utility.

The following package parameters are supported:

* `/ToolTipFeedback` - Show a tool tip when a NiftyWindows operation is being used. On by default.
* `/AutoSuspend` - Disable NiftyWindows when an application is running fullscreen. On by default.
* `/FocusFollowsMouse` - Automatically focus windows when the mouse passes over them. Off by default.
* `/Left` - Enable left mouse button features. On by default.
* `/Middle` - Enable middle mouse button features. On by default.
* `/Right` - Enable right mouse button features. On by default.
* `/Fourth` - Enable fourth mouse button features. On by default.
* `/Fifth` - Enable fifth mouse button features. On by default.

As an example: `choco install niftywindows --params "/AutoSuspend /ToolTipFeedback /Left /Right"`.

If no parameters are passed, the default values will be used. When values
are supplied, the rest of the features will be disabled. Features can be
turned on or off at any point from the taskbar menu.
