//
//  ZCMainViewController.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/5.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCMainViewController.h"
#import "ZCLoginViewController.h"

@interface ZCMainViewController ()

@end

@implementation ZCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    [btn setFrame:CGRectMake(100, 200, 100, 40)];
    [self.view addSubview:btn];
}

- (void)btnClicked{
    ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
