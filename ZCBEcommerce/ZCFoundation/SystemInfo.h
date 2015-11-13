//
//  SystemInfo.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/12.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#define IOS9_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IS_IPAD         (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define IS_IPHONE_5     [SNSystemInfo is_iPhone_5];


@interface SystemInfo : NSObject

/**
 *  系统版本
 *
 *  @return string
 */
+ (NSString *)osVersion;
/**
 *  硬件版本
 *
 *  @return string
 */
+ (NSString *)platform;
/**
 *  硬件版本名称
 *
 *  @return string
 */
+ (NSString *)platformString;
/**
 *  系统当前时间 格式：yyyy-MM-dd HH:mm:ss
 *
 *  @return string
 */
+ (NSString *)systemTimeInfo;
/**
 *  软件版本
 *
 *  @return string
 */
+ (NSString *)appVersion;
/**
 *  是否是iPhone5
 *
 *  @return string
 */
+ (BOOL)is_iPhone_5;
/**
 *  是否越狱
 *
 *  @return bool
 */
+ (BOOL) isJailBroken;
/**
 *  越狱版本
 *
 *  @return string
 */
+ (NSString *)jailBreaker;
/**
 *  本地ip
 *
 *  @return string
 */
+ (NSString *)localIPAddress;

@end
