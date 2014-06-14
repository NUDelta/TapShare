TapShare (formerly TapThat)
============

A mobile app that lets you tap twice on your phone to make a report. Used as a prototype to demonstrate the feasibility of low-effort crowdsourcing.

To run our app:

1. Download Xcode 5.1, if you have not already
2. Clone the repository where you plan to store it
3. Open up TapThat.xcodeproj
4. Edit the files or build on your phone

File Descriptions

MyLocationAppDelegate:
Contains logic for setting the initial view controller based on if the app was previously started or if the user has logged in

TutorialRootViewController:
Container for tutorial slides

TutorialViewController:
Tutorial slide template

MyLocationLoginViewController:
Login screen

MyLocationTableViewController:
Main view controller. Contains table to either track or visualize reports.

MyLocationMapViewController:
Allows for a visualization of various reports via MKMapView.

KnockViewController:
Contains logic to begin location tracking and knock detection.

coreMotionListener:
Contains logic to begin accelerometer updates. Acts as delegate for CMMotionManager.

knockDetector:
Contains knock/tap detection logic.

KBKeyboardHandler, KBKeyboardHandlerDelegate:
Classes used to provide keyboard animations/transitions when editing text fields. Original source from http://stackoverflow.com/questions/1775860/uitextfield-move-view-when-keyboard-appears/12402817#12402817. Github image at https://github.com/aceontech/KBKeyboardHandler.

Deprecated (will be removed in future releases):
MyLocationViewController
EventViewController
SubmitViewController
ReportsViewController
