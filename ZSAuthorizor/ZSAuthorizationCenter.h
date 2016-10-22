//
//  ZSAuthorizationCenter.h
//  ZSAuthorizor
//
//  Created by peter.shi on 16/6/22.
//  Copyright © 2016年 peter.shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSADefine.h"

extern NSString *KSEVICE_NAME_CAMERA;
extern NSString *KSEVICE_NAME_LOCATION;
extern NSString *KSEVICE_NAME_MICROPHONE;
extern NSString *KSEVICE_NAME_REMOTE;
extern NSString *KSEVICE_NAME_PHOTOS;

@class ZSAuthorizor;
/**
 *  权限管理中心
 */
@interface ZSAuthorizationCenter : NSObject
/**
 *  因为特殊原因需要保存一个远程通知的实例
 */
@property (nonatomic) ZSAuthorizor *remoteAuthorizor;

/**
 *  单例
 */
+ (instancetype)defaultCenter;

/**
 *  查询状态
 */
- (TZSAuthorizationStatus)queryStatus:(NSString *)sevice;

/**
 *  请求权限
 *
 *  @param sevice     权限类型
 *  @param completion 完成回调
 */
- (void)authorize:(NSString *)sevice completion:(void (^)(BOOL success))completion;

@end

