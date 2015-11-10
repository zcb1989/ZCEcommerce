//
//  ZCPublishButton.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/5.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCPublishButton.h"

@interface ZCPublishButton ()<UIActionSheetDelegate>

@end

@implementation ZCPublishButton

#pragma mark -
#pragma mark - Private Methods

//上下结构的 button
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    //imageView position 位置
    
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
    
}

#pragma mark -
#pragma mark - Life Cycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

+(instancetype)publishButton{
    ZCPublishButton *button = [[ZCPublishButton alloc] init];
    [button setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    
    [button sizeToFit];
    
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    UIViewController *viewController = tabBarController.selectedViewController;
//    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                              destructiveButtonTitle:nil
//                                                   otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
//    [actionSheet showInView:viewController.view];
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
