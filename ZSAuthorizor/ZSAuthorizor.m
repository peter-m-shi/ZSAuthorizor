//
//  ZSAuthorizor.m
//  ZSAuthorizor
//
//  Created by peter.shi on 16/6/22.
//  Copyright © 2016年 peter.shi. All rights reserved.
//

#import "ZSAuthorizor.h"


@implementation ZSAuthorizor
{
    dispatch_semaphore_t semaphore;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)main
{
    [super main];
    if ([NSThread isMainThread])
    {
        [self request];
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(),^(){
            [self request];
        });
    }
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}


- (void)request
{
    //TODO:do some thing
}


- (void)complete
{
    dispatch_semaphore_signal(semaphore);
}

@end
