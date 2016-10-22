//
// Created by peter.shi on 16/6/24.
// Copyright (c) 2016 peter.shi. All rights reserved.
//

#import "ZSLocationAuthorizor.h"
#import <UIKit/UIDevice.h>

@import CoreLocation;

@interface ZSLocationAuthorizor()<CLLocationManagerDelegate>
@end

@import CoreLocation;

@implementation ZSLocationAuthorizor
{
    CLLocationManager *_locationManager;
}

-(void)dealloc
{
    _locationManager.delegate = nil;
}


- (void)request
{
    [super request];

    if(IOS_VERSION >= 8.0)
    {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
    }
    else
    {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined)
    {
        [self complete];
    }
}


- (TZSAuthorizationStatus)status
{
    return (TZSAuthorizationStatus)[CLLocationManager authorizationStatus];
}

@end
