//
// Created by peter.shi on 16/6/24.
// Copyright (c) 2016 peter.shi. All rights reserved.
//

#import "ZSRemoteAuthorizor.h"
#import <objc/runtime.h>
#import "ZSAuthorizationCenter.h"

@import UIKit;

@implementation ZSRemoteAuthorizor

+ (void)initialize
{
    //交换Appdelegate中的两个接收通知注册回调的方法
    SEL orgSEL = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
    SEL overrideSEL = @selector(application:overrideDidRegisterForRemoteNotificationsWithDeviceToken:);
    [self methodSwizzleNotifationCallBack:orgSEL overrideSEL:overrideSEL];

    SEL failSEL = @selector(application:didFailToRegisterForRemoteNotificationsWithError:);
    SEL overrideFailSEL = @selector(application:overrideDidFailToRegisterForRemoteNotificationsWithError:);
    [self methodSwizzleNotifationCallBack:failSEL overrideSEL:overrideFailSEL];
}


+ (void)methodSwizzleNotifationCallBack:(SEL)orgSEL overrideSEL:(SEL)overideSEL
{
    if ([[UIApplication sharedApplication].delegate respondsToSelector:orgSEL])
    {
        Class class = [[UIApplication sharedApplication].delegate class];
        Method orgMethed = class_getInstanceMethod(class, orgSEL);

        //给Appdelegate添加一个方法，但是方法的实现在当前类里面，这是一个黑魔法o(╯□╰)o
        Class selfClass = [self class];
        Method selfMethod = class_getInstanceMethod(selfClass, overideSEL);
        IMP imp = method_getImplementation(selfMethod);

        class_addMethod(class, overideSEL, imp, method_getTypeEncoding(selfMethod));

        //交换添加的方法和原来的响应方法
        Method overrideMethod = class_getInstanceMethod(class, overideSEL);
        method_exchangeImplementations(orgMethed, overrideMethod);
    }
}

- (void)application:(UIApplication *)application overrideDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[ZSAuthorizationCenter defaultCenter].remoteAuthorizor complete];
    [self application:application overrideDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application overrideDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[ZSAuthorizationCenter defaultCenter].remoteAuthorizor complete];
    [self application:application overrideDidFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)request
{
    [super request];

    if(IOS_VERSION >= 8.0)
    {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType type = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
    }
}

- (TZSAuthorizationStatus)status
{
    return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications] ? EZSAuthorizationStatusAuthorized : EZSAuthorizationStatusDenied;
}

@end
