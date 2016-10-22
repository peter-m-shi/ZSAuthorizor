//
// Created by peter.shi on 16/6/24.
// Copyright (c) 2016 peter.shi. All rights reserved.
//

#import "ZSCameraAuthorizor.h"

@import AVFoundation;

@implementation ZSCameraAuthorizor

- (void)request
{
    [super request];

    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        [self complete];
    }];
}


- (TZSAuthorizationStatus)status
{
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo])
    {
        case AVAuthorizationStatusRestricted:
            return EZSAuthorizationStatusRestricted;
        case AVAuthorizationStatusDenied:
            return EZSAuthorizationStatusDenied;
        case AVAuthorizationStatusAuthorized:
            return EZSAuthorizationStatusAuthorized;
        default:
        case AVAuthorizationStatusNotDetermined:
            return EZSAuthorizationStatusNotDetermined;
    }
}

@end