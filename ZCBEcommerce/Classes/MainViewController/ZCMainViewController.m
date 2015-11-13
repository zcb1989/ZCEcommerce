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
    [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor brownColor];
    [btn setFrame:CGRectMake(100, 200, 100, 40)];
    [self.view addSubview:btn];
    
    ZCUIImageView *imageView = [[ZCUIImageView alloc] initWithFrame:CGRectMake(20, 260, 100, 100)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.imageURL = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D400/sign=74f7eeec257f9e2f70351c082f31e962/91529822720e0cf302b612f10846f21fbe09aa73.jpg"];
    [self.view addSubview:imageView];
    
    ZCUIImageView *imageView1 = [[ZCUIImageView alloc] initWithFrame:CGRectMake(130, 260, 100, 100)];
    imageView1.backgroundColor = [UIColor whiteColor];
    imageView1.imageURL = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D230/sign=ca7f8d7ea2ec08fa260014a469ef3d4d/14ce36d3d539b600078f2676eb50352ac75cb7a9.jpg"];
    [self.view addSubview:imageView1];
    
    ZCUIImageView *imageView2 = [[ZCUIImageView alloc] initWithFrame:CGRectMake(20, 380, 100, 100)];
    imageView2.backgroundColor = [UIColor whiteColor];
    imageView2.imageURL = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D400/sign=74f7eeec257f9e2f70351c082f31e962/91529822720e0cf302b612f10846f21fbe09aa73.jpg"];
    [self.view addSubview:imageView2];
    
    ZCUIImageView *imageView3 = [[ZCUIImageView alloc] initWithFrame:CGRectMake(130, 380, 100, 100)];
    imageView3.backgroundColor = [UIColor whiteColor];
    imageView3.imageURL = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D230/sign=ca7f8d7ea2ec08fa260014a469ef3d4d/14ce36d3d539b600078f2676eb50352ac75cb7a9.jpg"];
    [self.view addSubview:imageView3];
    
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
