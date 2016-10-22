//
//  ZSAuthorizationCenter.m
//  ZSAuthorizor
//
//  Created by peter.shi on 16/6/22.
//  Copyright © 2016年 peter.shi. All rights reserved.
//

#import "ZSAuthorizationCenter.h"
#import "ZSAuthorizor.h"
#import "ZSRemoteAuthorizor.h"

NSString *KSEVICE_NAME_CAMERA = @"Camera";
NSString *KSEVICE_NAME_LOCATION = @"Location";
NSString *KSEVICE_NAME_MICROPHONE = @"Microphone";
NSString *KSEVICE_NAME_REMOTE = @"Remote";
NSString *KSEVICE_NAME_PHOTOS = @"Photos";

@interface ZSAuthorizationCenter()

@property (nonatomic) NSOperationQueue *queue;

@end

@implementation ZSAuthorizationCenter

#pragma mark - public function -

+ (instancetype)defaultCenter
{
    static ZSAuthorizationCenter *authorizationCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authorizationCenter = [[ZSAuthorizationCenter alloc] init];
    });
    return authorizationCenter;
}

- (TZSAuthorizationStatus)queryStatus:(NSString *)sevice
{
    Class cls = [self classWithName:sevice];
    ZSAuthorizor *authorizor = [cls new];

    return authorizor.status;
}

- (void)authorize:(NSString *)sevice completion:(void (^)(BOOL success))completion
{
    Class cls = [self classWithName:sevice];
    if ([self alreadyExisted:cls])
    {
        return;
    }

    ZSAuthorizor *authorizor = [cls new];

    if ([authorizor isKindOfClass:[ZSRemoteAuthorizor class]])
    {
        self.remoteAuthorizor = authorizor;
    }

    __weak typeof(authorizor) weakAuthorizor = authorizor;
    [authorizor setCompletionBlock:^{
        if (completion)
        {
            BOOL success = (weakAuthorizor.status == EZSAuthorizationStatusAuthorized
                     || weakAuthorizor.status == EZSAuthorizationStatusAuthorizedAlways
                     || weakAuthorizor.status == EZSAuthorizationStatusAuthorizedWhenInUse);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(success);
            });
        }
    }];
    [self.queue addOperation:authorizor];
}

#pragma mark - private function -

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.queue = [[NSOperationQueue alloc] init];
        [self.queue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (Class)classWithName:(NSString *)name
{
    NSString *className = [NSString stringWithFormat:@"ZS%@Authorizor",name];
    return NSClassFromString(className);
}

- (BOOL)alreadyExisted:(Class)cls
{
    for (ZSAuthorizor *authorizor in self.queue.operations)
    {
        if ([authorizor isKindOfClass:cls])
        {
            return YES;
        }
    }
    return NO;
}

@end
