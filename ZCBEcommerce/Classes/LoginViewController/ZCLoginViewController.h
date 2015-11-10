//
//  ZCLoginViewController.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/5.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCLoginViewControllerDelegate <NSObject>

- (void)loginSuccess;

@end

@interface ZCLoginViewController : UIViewController

@property (nonatomic,weak) id <ZCLoginViewControllerDelegate> m_delegate;

@end
