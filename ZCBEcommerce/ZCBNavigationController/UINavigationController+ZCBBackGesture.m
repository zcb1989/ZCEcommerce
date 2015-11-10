//
//  UINavigationController+ZCBBackGesture.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/3.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "UINavigationController+ZCBBackGesture.h"

#import <objc/runtime.h>

@implementation UINavigationController (ZCBBackGesture)

- (BOOL)enableBackGesture{
    
    NSNumber *enableGestureNum = objc_getAssociatedObject(self, @selector(enableBackGesture));
    if (enableGestureNum) {
        return [enableGestureNum boolValue];
    }
    
    return false;
}

- (void)setEnableBackGesture:(BOOL)enableBackGesture{
    
    NSNumber *enableGestureNum = [NSNumber numberWithBool:enableBackGesture];
    objc_setAssociatedObject(self, @selector(setEnableBackGesture:), enableGestureNum, OBJC_ASSOCIATION_RETAIN);
    if (enableBackGesture) {
        [self.view addGestureRecognizer:[self panGestureRecognizer]];
    }else{
        [self.view removeGestureRecognizer:[self panGestureRecognizer]];
    }
}
- (UIPanGestureRecognizer *)panGestureRecognizer{
    
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, @selector(panGestureRecognizer));
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panToBack:)];
        objc_setAssociatedObject(self, @selector(panGestureRecognizer), panGestureRecognizer, OBJC_ASSOCIATION_RETAIN);
    }
    return panGestureRecognizer;
}
- (void)setStartPanPoint:(CGPoint)point{
    NSValue *startPanPointValue = [NSValue valueWithCGPoint:point];
    objc_setAssociatedObject(self, @selector(setStartPanPoint:), startPanPointValue, OBJC_ASSOCIATION_RETAIN);
}
- (CGPoint)startPanPoint{
    
    NSValue *startPanPointValue = objc_getAssociatedObject(self, @selector(startPanPoint));
    if (!startPanPointValue) {
        return CGPointZero;
    }
    return [startPanPointValue CGPointValue];
}
- (void)panToBack:(UIPanGestureRecognizer *)pan{
    UIView *currentView = self.topViewController.view;
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self setStartPanPoint:currentView.frame.origin];
        CGPoint velocity = [pan velocityInView:self.view];
        if (velocity.x !=0) {
            [self willShowPreViewController];
        }
        return;
    }
    CGPoint currentPostion = [pan translationInView:self.view];
    CGFloat xoffset = [self startPanPoint].x + currentPostion.x;
    CGFloat yoffset = [self startPanPoint].y + currentPostion.y;
    if (xoffset > 0) {
        //向右滑
        if (true) {
            xoffset = xoffset>self.view.frame.size.width ? self.view.frame.size.width : xoffset;
        }else{
            xoffset = 0;
        }
    }else if (xoffset < 0){
        //向左滑
        if (currentView.frame.origin.x > 0) {
            xoffset = xoffset < - self.view.frame.size.width ? -self.view.frame.size.width:xoffset;
        }else{
            xoffset = 0;
        }
    }
    
    if (!CGPointEqualToPoint(CGPointMake(xoffset, yoffset), currentView.frame.origin)) {
        if (xoffset <= 0) {
            //修复滑动过程中快速左滑会出现偏移或闪屏的bug
            xoffset = 0;
        }
        [self layoutCurrentViewWithOffset:UIOffsetMake(xoffset, yoffset)];
    }
    
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        if (currentView.frame.origin.x == 0) {
            
        }else{
            if (currentView.frame.origin.x < BackGestureOffsetXToBack) {
                [self hidePreViewController];
            }else{
                [self showPreViewController];
            }
        }
    }
}
- (void)willShowPreViewController{
    NSInteger count = self.viewControllers.count;
    if (count >1) {
        UIViewController *currentVC = [self topViewController];
        UIViewController *preVC = [self.viewControllers objectAtIndex:count - 2];
        [currentVC.view.superview insertSubview:preVC.view belowSubview:currentVC.view];
    }
}

- (void)layoutCurrentViewWithOffset:(UIOffset)offset{
    NSInteger count = self.viewControllers.count;
    if (count >1) {
        UIViewController *currentVC = [self topViewController];
        UIViewController *preVC = [self.viewControllers objectAtIndex:count - 2];
        [currentVC.view setFrame:CGRectMake(offset.horizontal, self.view.bounds.origin.y, self.view.frame.size.width, currentVC.view.frame.size.height)];
        [preVC.view setFrame:CGRectMake(offset.horizontal/2 - self.view.frame.size.width/2, self.view.bounds.origin.y, self.view.frame.size.width, preVC.view.frame.size.height)];
    }
}
- (void)hidePreViewController{
    NSInteger count = self.viewControllers.count;
    if (count >1) {
        UIViewController *preVC = [self.viewControllers objectAtIndex:count - 2];
        UIView *currentView = self.topViewController.view;
        NSTimeInterval animatedTime = 0;
        animatedTime = ABS(self.view.frame.size.width - currentView.frame.origin.x)/self.view.frame.size.width * 0.35;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:animatedTime animations:^{
            [self layoutCurrentViewWithOffset:UIOffsetMake(0, 0)];
        }completion:^(BOOL finished){
            [preVC.view removeFromSuperview];
        }];
    }
}
- (void)showPreViewController{
    NSInteger count = self.viewControllers.count;
    if (count > 1) {
        UIView *currentView = self.topViewController.view;
        NSTimeInterval animatedTime = 0;
        animatedTime = ABS(self.view.frame.size.width - currentView.frame.origin.x) / self.view.frame.size.width * 0.35;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:animatedTime animations:^{
            [self layoutCurrentViewWithOffset:UIOffsetMake(self.view.frame.size.width, 0)];
        } completion:^(BOOL finished) {
            [self popViewControllerAnimated:false];
        }];
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:self.view];
        if ([panGesture velocityInView:self.view].x < 600 && ABS(translation.x)/ABS(translation.y)>1) {
            return true;
        }
        return false;
    }
    return true;
}
@end
