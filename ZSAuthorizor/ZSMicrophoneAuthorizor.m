//
// Created by peter.shi on 16/6/24.
// Copyright (c) 2016 peter.shi. All rights reserved.
//

#import "ZSMicrophoneAuthorizor.h"

@import AVFoundation;

@implementation ZSMicrophoneAuthorizor


- (void)request
{
    [super request];

    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        [self complete];
    }];
}


- (TZSAuthorizationStatus)status
{
    switch ([[AVAudioSession sharedInstance] recordPermission])
    {
        case AVAudioSessionRecordPermissionGranted:
            return EZSAuthorizationStatusAuthorized;
        case AVAudioSessionRecordPermissionDenied:
            return EZSAuthorizationStatusDenied;
        case AVAudioSessionRecordPermissionUndetermined:
        default:
            return EZSAuthorizationStatusNotDetermined;
    }
}

@end