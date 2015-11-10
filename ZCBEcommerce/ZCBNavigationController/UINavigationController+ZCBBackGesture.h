//
//  UINavigationController+ZCBBackGesture.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/3.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define BackGestureOffsetXToBack 80 // >80 show pre vc

@interface UINavigationController (ZCBBackGesture)<UIGestureRecognizerDelegate>
/**
 *  是否使用手势返回前一页 enableBackGesture YES:使用 ,NO:不使用, default is NO
 */
@property (assign,nonatomic) BOOL enableBackGesture;
@end
