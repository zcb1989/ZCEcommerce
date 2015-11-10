//
//  ZCMessageViewController.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/6.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCMessageViewController.h"

@interface ZCMessageViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *sourceArray;

@end

@implementation ZCMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    
    [self createSearchController];
    [self dataArrayInit];
    
    
    
    
}
#pragma mark - dataInit
#pragma mark - UISearchController create
- (void)createSearchController{
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.placeholder = @"搜索";
    _searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchController.searchBar;
}

- (void)dataArrayInit{
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"C",@"OC",@"UI",@"iOS",@"java",@"C++",@"C#",@"json",@"xml",@"XML",@"大锤",@"大鹏",@"叫兽",@"至尊玉",@"小爱",@"孔女神",@"孔连顺",@"柳岩", @"iPhone",@"iPhone6s",@"iPhone6s plus",@"iPad",@"iWatch",@"iPod",@"iTouch",@"iPad Pro",@"iPad Air", nil];
    self.sourceArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UISearchControllerDelegate
- (void)didDismissSearchController:(UISearchController *)searchController{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:self.sourceArray];
    [self.tableView reloadData];
}

#pragma mark - UISearchResultsUpdating
/**
 *  什么时候被调用
 1.当点击searchBar进入编辑模式（成为第一响应者）
 2.当searchBar 里面的内容发生改变（只要输入字符）
 3.当点击cancel 按钮的时候 会清空 searchBar 这时也会被调用
 *
 *  @param searchController
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = searchController.searchBar.text;
    if (text.length == 0) {
        
        return;
    }
    
    [self.dataArray removeAllObjects];
    
    for (NSString *str in self.sourceArray) {
        NSRange range = [str rangeOfString:text options:NSCaseInsensitiveSearch];//不区分大小写 进行检索
        
//        NSRange range = [str rangeOfString:text];//区分大小写
        if (range.location != NSNotFound) {
            [self.dataArray addObject:str];//重新把结果放入数据源
        }
    }
    //刷新表格
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
{
    searchBar.showsCancelButton = YES;
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
}

@end
