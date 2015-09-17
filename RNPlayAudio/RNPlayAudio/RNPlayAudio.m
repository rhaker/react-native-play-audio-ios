//
//  RNPlayAudio.m
//  RNPlayAudio
//  Created by Ross Haker on 9/13/15.
//

#import "RNPlayAudio.h"

@implementation RNPlayAudio {
    
    AVAudioPlayer *audioPlayer;
    
}

// Expose this module to the React Native bridge
RCT_EXPORT_MODULE()

// Persist data
RCT_EXPORT_METHOD(startAudio:(NSString *)fileName
                  errorCallback:(RCTResponseSenderBlock)failureCallback
                  callback:(RCTResponseSenderBlock)successCallback) {
    
    // Validate the file name has positive length
    if ([fileName length] < 1) {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Your file does not have a name."
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    // Validate the file name has an extension
    NSRange isRange = [fileName rangeOfString:@"." options:NSCaseInsensitiveSearch];
    
    if (isRange.location == 0) {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Your file does not have a valid name and extension."
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    } else {
        
        if (isRange.location == NSNotFound) {
            
            // Show failure message
            NSDictionary *resultsDict = @{
                                          @"success" : @NO,
                                          @"errMsg"  : @"Your file does not have a valid extension."
                                          };
            
            // Javascript error handling
            failureCallback(@[resultsDict]);
            return;
        }
        
    }
    
    // Validate for .caf, .mp3, .aac, , .wav, .aiff
    NSRange isRangeCaf = [fileName rangeOfString:@".caf" options:NSCaseInsensitiveSearch];
    NSRange isRangeMp3 = [fileName rangeOfString:@".mp3" options:NSCaseInsensitiveSearch];
    NSRange isRangeM4a= [fileName rangeOfString:@".m4a" options:NSCaseInsensitiveSearch];
    NSRange isRangeWav = [fileName rangeOfString:@".wav" options:NSCaseInsensitiveSearch];
    NSRange isRangeAif = [fileName rangeOfString:@".aif" options:NSCaseInsensitiveSearch];
    
    if ((isRangeCaf.location == NSNotFound) && (isRangeMp3.location == NSNotFound) && (isRangeM4a.location == NSNotFound) && (isRangeWav.location == NSNotFound) && (isRangeAif.location == NSNotFound)) {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"File should be either a .caf, .mp3, .m4a, .wav, or .aif"
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    // Create an array of directory Paths, to allow us to get the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // The documents directory is the first item
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Create the path that the file will be stored at
    NSString *pathForFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    
    NSURL *audioFileURL = [NSURL fileURLWithPath:pathForFile];
    
    // Validate that the file exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if file exists
    if (![fileManager fileExistsAtPath:pathForFile]){
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"File does not exist in app documents directory."
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    NSError *error = nil;
    
    // Check if audioPlayer exists for initialization
    if (!audioPlayer) {
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL: audioFileURL
                       error:&error];
        
    }
    
    // Validate no errors in the session initialization
    if (error) {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : [error localizedDescription]
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    } else {
        
        // play the recording
        [audioPlayer play];
        
        // Craft a success return message
        NSDictionary *resultsDict = @{
                                      @"success" : @YES,
                                      @"successMsg" : @"Successfully started."
                                      };
        
        // Call the JavaScript sucess handler
        successCallback(@[resultsDict]);
        
    }
    
}

// Persist data
RCT_EXPORT_METHOD(stopAudio:(NSString *) fileName
                  errorCallback:(RCTResponseSenderBlock)failureCallback
                  callback:(RCTResponseSenderBlock)successCallback) {
    
    // Create an array of directory Paths, to allow us to get the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // The documents directory is the first item
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Create the path that the file will be stored at
    NSString *pathForFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    
    // Prepare the recording
    NSURL *audioFileURL = [NSURL fileURLWithPath:pathForFile];
    
    // Validate that the file exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if file exists
    if (![fileManager fileExistsAtPath:pathForFile]){
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"File does not exist in app documents directory."
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    NSError *error = nil;
    
    // Re-intialize the audioPlayer to stop and go to beginning on next play
    audioPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL: audioFileURL
                   error:&error];
    
    // if recording is still in progress, stop
    if (audioPlayer.playing) {
        
        [audioPlayer stop];
        
    }
    
    // Craft a success return message
    NSDictionary *resultsDict = @{
                                  @"success" : @YES,
                                  @"successMsg"  : @"Successfully stopped."
                                  };
    
    // Call the JavaScript sucess handler
    successCallback(@[resultsDict]);
    
}

// Persist data
RCT_EXPORT_METHOD(pauseAudio:(NSString *) fileName
                  errorCallback:(RCTResponseSenderBlock)failureCallback
                  callback:(RCTResponseSenderBlock)successCallback) {
    
    // Create an array of directory Paths, to allow us to get the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // The documents directory is the first item
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Create the path that the file will be stored at
    NSString *pathForFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    
    // Prepare the recording
    NSURL *audioFileURL = [NSURL fileURLWithPath:pathForFile];
    
    // Validate that the file exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if file exists
    if (![fileManager fileExistsAtPath:pathForFile]){
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"File does not exist in app documents directory."
                                      };
        
        // Javascript error handling
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    NSError *error = nil;
    
    // Check that audioPlay exists to prevent play from going to beginning of audio
    if (!audioPlayer) {
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL: audioFileURL
                       error:&error];
        
    }
    
    // if recording is in progress, pause
    if (audioPlayer.playing) {
        
        [audioPlayer pause];
        
    }
    
    // Craft a success return message
    NSDictionary *resultsDict = @{
                                  @"success" : @YES,
                                  @"successMsg"  : @"Successfully paused."
                                  };
    
    // Call the JavaScript sucess handler
    successCallback(@[resultsDict]);
    
}

@end

