//
//  UINavigationController+ZCFullScreenPopGesture.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/4.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationController (ZCFullScreenPopGesture)

//
@property (nonatomic,strong,readonly) UIPanGestureRecognizer *zc_fullscreenPopGestureRecognizer;
@property (nonatomic,assign) BOOL zc_viewControllerBasedNavigationBarAppearanceEnabled;
@end

@interface UIViewController (ZCFullScreenPopGesture)

@property (nonatomic,assign) BOOL zc_interactivePopDisabled;
@property (nonatomic,assign) BOOL zc_prefersNavigationBarHidden;
@property (nonatomic,assign) CGFloat zc_interactivePopMaxAllowedInitialDiatanceToLeftEdge;


@end
