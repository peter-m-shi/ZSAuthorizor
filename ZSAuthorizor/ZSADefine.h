//
// Created by peter.shi on 16/6/24.
// Copyright (c) 2016 peter.shi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/*
 *  权限状态枚举
 */
typedef NS_ENUM(NSInteger , TZSAuthorizationStatus)
{
    // User has not yet made a choice with regards to this application
    EZSAuthorizationStatusNotDetermined = 0,

    // This application is not authorized to use location services.  Due
    // to active restrictions on location services, the user cannot change
    // this status, and may not have personally denied authorization
    EZSAuthorizationStatusRestricted,

    // User has explicitly denied authorization for this application, or
    // location services are disabled in Settings.
    EZSAuthorizationStatusDenied,

    // User has granted authorization to use their location at any time,
    // including monitoring for regions, visits, or significant location changes.
    EZSAuthorizationStatusAuthorizedAlways,

    // User has granted authorization to use their location only when your app
    // is visible to them (it will be made visible to them if you continue to
    // receive location updates while in the background).  Authorization to use
    // launch APIs has not been granted.
    EZSAuthorizationStatusAuthorizedWhenInUse,

    // This value is deprecated, but was equivalent to the new -Always value.
    EZSAuthorizationStatusAuthorized
};
