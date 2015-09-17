# react-native-play-audio-ios

This is a wrapper for react-native that plays audio. The options are play, stop, and pause.  Stopping the audio and then playing the audio will restart the audio from the beginning. Pausing the audio and then playing will start where the pause occurred. This is for ios only.

# Add it to your project

npm install react-native-play-audio-ios --save

In XCode, in the project navigator, right click Libraries ➜ Add Files to [your project's name]

Go to node_modules ➜ react-native-play-audio-ios and add RNPlayAudio.xcodeproj

In XCode, in the project navigator, select your project. Add libRNPlayAudio.a to your project's Build Phases ➜ Link Binary With Libraries

Click RNPlayAudio.xcodeproj in the project navigator and go the Build Settings tab. Make sure 'All' is toggled on (instead of 'Basic'). Look for Header Search Paths and make sure it contains both $(SRCROOT)/../react-native/React and $(SRCROOT)/../../React - mark both as recursive.

Run your project (Cmd+R)

Setup trouble?

If you get stuck, take a look at Brent Vatne's blog. His blog is my go to reference for this stuff.

# Api Setup

var React = require('react-native');

var { NativeModules } = React;

var { RNPlayAudio } = NativeModules;

// Start Audio

RNPlayAudio.startAudio(

    "test.wav", // filename

    function errorCallback(results) {

        console.log('JS Error: ' + results['errMsg']);

    },

    function successCallback(results) {

        console.log('JS Success: ' + results['successMsg']);

    }

);

// Stop Audio

RNPlayAudio.stopAudio(

    "test.wav", // filename

    function errorCallback(results) {

        console.log('JS Error: ' + results['errMsg']);

    },

    function successCallback(results) {

        console.log('JS Success: ' + results['successMsg']);

    }

);


// Pause Audio

RNPlayAudio.pauseAudio(

    "test.wav", // filename

    function errorCallback(results) {

        console.log('JS Error: ' + results['errMsg']);

    },

    function successCallback(results) {

        console.log('JS Success: ' + results['successMsg']);

    }

);

# Additional Notes

The audio to be played must exist in the app documents directory. The format/file type of the audio should be either a .caf, .mp3, .wav, .aif, or .m4a.

# Error Callback

The following will cause an error callback (use the console.log to see the specific message):

1) Filename not included in api call

2) Filename is a hidden file

3) File is not .caf, .mp3, .wav, .aif, or .m4a

4) File does not exist in the app documents directory

# Acknowledgements

Special thanks to Joshua Sierles for his work and code on react-native-audio. Brent Vatne for his posts on creating a react native packager. Some portions of this code have been based on answers from stackoverflow. This package also owes a special thanks to the tutorial by Jay Garcia at Modus Create on how to create a custom react native module.
