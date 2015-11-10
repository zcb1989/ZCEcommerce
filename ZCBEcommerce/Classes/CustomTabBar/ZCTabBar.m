//
//  ZCTabBar.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/5.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCTabBar.h"
#import "ZCPublishButton.h"

#define ButtonNumber 5


@interface ZCTabBar ()

@property (nonatomic, strong) ZCPublishButton *publishButton;/**< 发布按钮 */

@end


@implementation ZCTabBar

//-(instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        ZCPublishButton *button = [ZCPublishButton publishButton];
//        [self addSubview:button];
//        self.publishButton = button;
//        
//    }
//    
//    return self;
//}

//-(void)layoutSubviews{
//    
//    
//    NSLog(@"%s",__func__);
//    
//    [super layoutSubviews];
//    
//    CGFloat barWidth = self.frame.size.width;
//    CGFloat barHeight = self.frame.size.height;
//    
//    CGFloat buttonW = barWidth / ButtonNumber;
//    CGFloat buttonH = barHeight - 2;
//    CGFloat buttonY = 1;
//    
//    NSInteger buttonIndex = 0;
//    
//    self.publishButton.center = CGPointMake(barWidth * 0.5, barHeight * 0.3);
//    
//    for (UIView *view in self.subviews) {
//        
//        NSString *viewClass = NSStringFromClass([view class]);
//        if (![viewClass isEqualToString:@"UITabBarButton"]) continue;
//        
//        CGFloat buttonX = buttonIndex * buttonW;
//        if (buttonIndex >= 2) { // 右边2个按钮
//            buttonX += buttonW;
//        }
//        
//        view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        
//        
//        buttonIndex ++;
//        
//        
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
