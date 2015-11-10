//
//  ViewController.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/3.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ViewController.h"
//或者使用
//#import "UINavigationController+ZCBBackGesture.h"
//    self.navigationController.enableBackGesture = YES;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItem];
    
}

#pragma mark - RightBarButtonItem
- (void)addRightBarButtonItem{
    
    UIButton *rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0, 0, 20, 20);
    [rightButtonItem setFrame:frame];
    [rightButtonItem setBackgroundImage:[UIImage imageNamed:@"icon_search@2x"] forState:UIControlStateNormal];
    rightButtonItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightButtonItem addTarget:self action:@selector(searchOther) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonItem];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)searchOther{
    
//    self.navigationController.enableBackGesture = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
