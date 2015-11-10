//
//  ZCMessageViewController.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/6.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCMessageViewController : UITableViewController

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSArray *filterData;
@property (nonatomic,strong) UISearchController *searchController;

@end
