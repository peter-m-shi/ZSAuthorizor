//
// Created by peter.shi on 16/6/24.
// Copyright (c) 2016 peter.shi. All rights reserved.
//

#import "ZSPhotosAuthorizor.h"
#import <UIKit/UIDevice.h>

@import AssetsLibrary;
@import Photos;

@implementation ZSPhotosAuthorizor

- (void)request
{
    [super request];

    if(IOS_VERSION >= 8.0)
    {
        __weak typeof(self) ws = self;
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [ws complete];
        }];
    }
    else
    {
        __weak typeof(self) ws = self;
        [[ALAssetsLibrary new] enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            [ws complete];
            *stop = YES;
        }failureBlock:^(NSError *error) {
            [ws complete];
        }];
    }
}


- (TZSAuthorizationStatus)status
{
    if(IOS_VERSION >= 8.0)
    {
        switch ([PHPhotoLibrary authorizationStatus])
        {
            case PHAuthorizationStatusAuthorized:
                return EZSAuthorizationStatusAuthorized;
            case PHAuthorizationStatusDenied:
                return EZSAuthorizationStatusDenied;
            case PHAuthorizationStatusRestricted:
                return EZSAuthorizationStatusRestricted;
            case PHAuthorizationStatusNotDetermined:
            default:
                return EZSAuthorizationStatusNotDetermined;
        }
    }
    else
    {
        switch ([ALAssetsLibrary authorizationStatus])
        {
            case ALAuthorizationStatusAuthorized:
                return EZSAuthorizationStatusAuthorized;
            case ALAuthorizationStatusDenied:
                return EZSAuthorizationStatusDenied;
            case ALAuthorizationStatusRestricted:
                return EZSAuthorizationStatusRestricted;
            case ALAuthorizationStatusNotDetermined:
            default:
                return EZSAuthorizationStatusNotDetermined;
        }
    }

}
@end