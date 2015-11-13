//
//  ZCLogger.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/12.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(UInt8,ZCLogLevel) {
    ZCLogLevelDEBUG     = 1,
    ZCLogLevelINFO      = 2,
    ZCLogLevelWARN      = 3,
    ZCLogLevelERROR     = 4,
    ZCLogLevelOFF       = 5,
};

#define ZC_LOG_MACRO(level, fmt, ...)     [[ZCLogger sharedInstance] logLevel:level format:(fmt), ##__VA_ARGS__]

#define ZC_LOG_PRETTY(level, fmt, ...)    \
do {ZC_LOG_MACRO(level, @"%s #%d " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);} while(0)


#define ZCLogError(frmt, ...)   ZC_LOG_PRETTY(ZCLogLevelERROR, frmt, ##__VA_ARGS__)
#define ZCLogWarn(frmt, ...)    ZC_LOG_PRETTY(ZCLogLevelWARN,  frmt, ##__VA_ARGS__)
#define ZCLogInfo(frmt, ...)    ZC_LOG_PRETTY(ZCLogLevelINFO,  frmt, ##__VA_ARGS__)
#define ZCLogDebug(frmt, ...)   ZC_LOG_PRETTY(ZCLogLevelDEBUG, frmt, ##__VA_ARGS__)
#define DLog(frmt, ...) ZC_LOG_PRETTY(ZCLogLevelDEBUG, frmt, ##__VA_ARGS__)

@interface ZCLogger : NSObject

@property (nonatomic,assign) ZCLogLevel  logLevel;

+(instancetype) sharedInstance;
+(void)startWithLogLevel:(ZCLogLevel)logLevel;
-(void)logLevel:(ZCLogLevel)level format:(NSString *)format,...;
-(void)logLevel:(ZCLogLevel)level message:(NSString *)message;

@end
