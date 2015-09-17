//
//  RNPlayAudio.h
//  RNPlayAudio
//  Created by Ross Haker on 9/13/15.
//


#import <AVFoundation/AVFoundation.h>
#import <RCTBridge.h>

@interface RNPlayAudio : NSObject <RCTBridgeModule, AVAudioPlayerDelegate>

@end