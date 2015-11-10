//
//  UINavigationController+ZCFullScreenPopGesture.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/4.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "UINavigationController+ZCFullScreenPopGesture.h"
#import <objc/runtime.h>

@interface _ZCFullscreenPopGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>
@property (nonatomic,weak) UINavigationController *navigationController;

@end

@implementation _ZCFullscreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count <=1) {
        
        return NO;
    }
    
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.zc_interactivePopDisabled) {
        
        return NO;
    }
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.zc_interactivePopMaxAllowedInitialDiatanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}
@end

#pragma mark - ZCFullscreenPopGesturePrivate
typedef void (^_ZCViewControllerWillAppearInJectBlock)(UIViewController *viewController,BOOL animated);
@interface UIViewController (ZCFullscreenPopGesturePrivate)

@property (nonatomic,copy) _ZCViewControllerWillAppearInJectBlock zc_willAppearInjectBlock;

@end

@implementation UIViewController (ZCFullscreenPopGesturePrivate)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(zc_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)zc_viewWillAppear:(BOOL)animated
{
    // Forward to primary implementation.
    [self zc_viewWillAppear:animated];
    
    if (self.zc_willAppearInjectBlock) {
        self.zc_willAppearInjectBlock(self, animated);
    }
}

- (_ZCViewControllerWillAppearInJectBlock)zc_willAppearInjectBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZc_willAppearInjectBlock:(_ZCViewControllerWillAppearInJectBlock)block
{
    objc_setAssociatedObject(self, @selector(zc_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
#pragma mark - ZCFullScreenPopGesture
@implementation UINavigationController (ZCFullScreenPopGesture)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^{
       
        Class class = [self class];
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(zc_pushViewController:animated:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (void)zc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.zc_fullscreenPopGestureRecognizer]) {
        
        // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.zc_fullscreenPopGestureRecognizer];
        
        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.zc_fullscreenPopGestureRecognizer.delegate = self.zc_popGestureRecognizerDelegate;
        [self.zc_fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Handle perferred navigation bar appearance.
    [self zc_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    // Forward to primary implementation.
    if (![self.viewControllers containsObject:viewController]) {
        [self zc_pushViewController:viewController animated:animated];
    }
}
- (void)zc_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    if (!self.zc_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    _ZCViewControllerWillAppearInJectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.zc_prefersNavigationBarHidden animated:animated];
        }
    };
    
    appearingViewController.zc_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.zc_willAppearInjectBlock) {
        disappearingViewController.zc_willAppearInjectBlock = block;
    }
}

- (_ZCFullscreenPopGestureRecognizerDelegate *)zc_popGestureRecognizerDelegate
{
    _ZCFullscreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    
    if (!delegate) {
        delegate = [[_ZCFullscreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)zc_fullscreenPopGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

- (BOOL)zc_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.zc_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setZc_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(zc_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark - ZCFullScreenPopGesture
@implementation UIViewController (ZCFullScreenPopGesture)

- (BOOL)zc_interactivePopDisabled{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setZc_interactivePopDisabled:(BOOL)zc_interactivePopDisabled{
    objc_setAssociatedObject(self, @selector(zc_interactivePopDisabled), @(zc_interactivePopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zc_prefersNavigationBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setZc_prefersNavigationBarHidden:(BOOL)zc_prefersNavigationBarHidden{
    objc_setAssociatedObject(self, @selector(zc_prefersNavigationBarHidden), @(zc_prefersNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)zc_interactivePopMaxAllowedInitialDiatanceToLeftEdge{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setZc_interactivePopMaxAllowedInitialDiatanceToLeftEdge:(CGFloat)zc_interactivePopMaxAllowedInitialDiatanceToLeftEdge{
    
    SEL key = @selector(zc_interactivePopMaxAllowedInitialDiatanceToLeftEdge);
    objc_setAssociatedObject(self, key, @(MAX(0, zc_interactivePopMaxAllowedInitialDiatanceToLeftEdge)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end