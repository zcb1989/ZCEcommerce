//
//  ZCRootViewController.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/5.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCRootViewController.h"
#import "AppDelegate.h"
#import "ZCLoginViewController.h"
#import "ZCBNavigationController.h"

#import "ZCTabBarController.h"


@interface ZCRootViewController ()<ZCLoginViewControllerDelegate>

@property (nonatomic ,weak) AppDelegate *m_appDelegate;
@property (nonatomic ,weak) UIWindow *m_window;

@end

@implementation ZCRootViewController

+ (id)sharedAppDelegateInstance
{
    static ZCRootViewController *rootControl = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        rootControl = [[[self class] alloc] init];
    });
    return rootControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getProperty];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self enterLoginViewController];
}

- (void)enterLoginViewController
{
    NSLog(@"跳转登录界面");
    ZCLoginViewController *lvc = [[ZCLoginViewController alloc] init];
    lvc.m_delegate = self;
    //NSLog(@"self.m_delegate=%@",lvc.m_delegate);
    self.m_window.rootViewController = lvc;//至此rootViewController 引用计数为0
}

#pragma mark - LoginViewControllerDelegate
- (void)loginSuccess
{
    NSLog(@"button Presss in Login");
    [self gotoHomeViewController];
}

- (void)gotoHomeViewController
{
    ZCTabBarController *zcmainVC = [[ZCTabBarController alloc] init];
    self.m_window.rootViewController = zcmainVC;
}

- (void)getProperty{
    
    self.m_appDelegate = [[UIApplication sharedApplication] delegate];
    self.m_window = self.m_appDelegate.window;
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
