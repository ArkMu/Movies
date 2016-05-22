//
//  MeVC.m
//  Movies
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MeVC.h"

#import "Account.h"

#import "SDImageCache.h"

#import <AVOSCloud/AVOSCloud.h>

#import "CollectTableVC.h"
#import "MapVC.h"

@interface MeVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arr;

@end

@implementation MeVC

static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    
    _arr = @[@"简介", @"免责声明", @"清除缓存", @"收藏"];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [btn setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoMapView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)gotoMapView {
    MapVC *map = [self.storyboard instantiateViewControllerWithIdentifier:@"MapVC"];
    [self.navigationController pushViewController:map animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    label.font = [UIFont systemFontOfSize:13.0];

    if (indexPath.section == 0) {
        label.text = _arr[indexPath.row];
        label.textAlignment = NSTextAlignmentLeft;
        label.frame = CGRectMake(20, 0, self.view.frame.size.width - 20, 44);
        [cell addSubview:label];
        return cell;
    }

    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"退出";
    [cell addSubview:label];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self showAlertMessage:@"这是一款关于电影的网站" withIndexPath:indexPath];
        } else if (indexPath.row == 1) {
            [self showAlertMessage:@"本站仅为测试之用，不用于一切商业用途，因本站所带来的一切经济损失，本站概不负责" withIndexPath:indexPath];
        } else if (indexPath.row == 2) {
            NSUInteger memorySize =  [[SDImageCache sharedImageCache] getSize];
            CGFloat size = (CGFloat)memorySize / 1024 / 1024;
            [self showAlertMessage:[NSString stringWithFormat:@"缓存: %.4fM", size] withIndexPath:indexPath];
        } else {
            CollectTableVC *collect = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectTableVC"];
            
            [self.navigationController pushViewController:collect animated:NO];
        }
    } else {
    
        UINavigationController *navi = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
        [[Account shareAccount] deleteUserInfo];
//        [AVUser logOut];

        [self presentViewController:navi animated:YES completion:nil];
    }
}

- (void)showAlertMessage:(NSString *)message withIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (indexPath.row == 2) {
            [[SDImageCache sharedImageCache] clearDisk];
        }
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:NO completion:nil];
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
