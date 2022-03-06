# Overview

This is a speech booster app. It was designed with the intention of recording whispers and playing them back loud enough to be heard easily. It was an effective introduction to iOS fundamentals, especially regarding realtime audio processing using AVAudioEngine.

I made this as a proof of concept with the intention of helping someone who is having difficulty speaking for medical reasons. I ran to a few difficulties with the exact implementation details I had originally envisoned. Some of those sticking points are detailed under the future work section. The greatest success of this project was learning the basics of AVAudioEngine, which can be poorly documented in spots. Some of what was learned can be found in the software demo linked below.

[Software Demo Video](https://youtu.be/AoF9Z9ktm4w)

# Development Environment

I used XCode 13 to program this app and an iPhone 11 to test it.

I used UIKit, AVFoundation, and AVAudioEngineto build the app. UIKit was used to handle updating the user-interface. AVFoundation was used to handle the audio session and a subset of AVFoundation, AVAudioEngine, was used and explored extensively in the process of getting a functional demo.

# Useful Websites

* [How I learned my orignal vision wasn't possible.](https://stackoverflow.com/questions/41487905/avaudiosession-microphone-headphone-as-input-and-iphone-speaker-as-output)
* [WWDC Talk Explaining AVAudioEngine](https://www.youtube.com/watch?v=FlMaxen2eyw)
* [AVAudioEngine Simply](https://www.youtube.com/watch?v=g57pGi_uHeY)

# Future Work

* Adjust the way the AVAudioFile saving is handled for a better user experience.
* Investigate another library (perhaps CoreAudio) to get input from headphones and output through the iPhone speaker, as originally intended. 
* Flesh out the UI to produce a more visually/feature rich user experience. 
