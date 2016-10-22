//
//  ZSAuthorizor.h
//  ZSAuthorizor
//
//  Created by peter.shi on 16/6/22.
//  Copyright © 2016年 peter.shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSADefine.h"

/**
 *  权限基类
 */
@interface ZSAuthorizor : NSOperation

@property (nonatomic) TZSAuthorizationStatus status;

/**
 *  请求权限
 */
- (void)request;

/**
 *  完成回调
 */
- (void)complete;

@end
