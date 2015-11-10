//
//  ZCBNavigationController.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/3.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCBNavigationController.h"

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@interface ZCBNavigationController ()

@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
@end

@implementation ZCBNavigationController

#pragma mark 一个类只会调用一次
+ (void)initialize{
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObjects:[ZCBNavigationController class], nil]];
    
//    // 2.设置导航栏的背景图片
//    NSString *navBarBg = nil;
//    if (iOS7) { // iOS7
//        navBarBg = @"NavBar64";
//        navBar.tintColor = [UIColor whiteColor];
//    } else { // 非iOS7
//        navBarBg = @"NavBar";
//    }
//    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    
    navBar.barTintColor = [UIColor colorWithRed:64/255.0 green:137/255.0 blue:217/255.0 alpha:1];
    
    // 3.标题
#ifdef __IPHONE_7_0
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
#else
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
#endif
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //解决tabBar的导航控制push时，被push的viewcontroller隐藏tabBar。
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
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
