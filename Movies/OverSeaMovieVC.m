//
//  OverSeaMovieVC.m
//  Movies
//
//  Created by qingyun on 16/4/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "OverSeaMovieVC.h"

#import "OverSeasVC.h"

#import "Masonry.h"

@interface OverSeaMovieVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *locationArr;

@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation OverSeaMovieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"海外";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _locationArr = @[@"美国",@"韩国",@"日本"];
    _btnArr = [NSMutableArray array];
    
    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageVC"];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    OverSeasVC *overVC = [self viewControllerAtIndex:0];
    
    [_pageViewController setViewControllers:@[overVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(560);
    }];
    
    [containerView addSubview:_pageViewController.view];

    [_pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(containerView);
        make.size.mas_equalTo(containerView);
    }];
    
    
    for (int i = 0; i < _locationArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_locationArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        [_btnArr addObject:btn];
        btn.frame = CGRectMake(125 * i, 0, 125, 40);
        
    }
    
    [self setBtnColor:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (OverSeasVC *)viewControllerAtIndex:(NSInteger)index {
    OverSeasVC *overVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OverSeasVC"];
    overVC.index = index;
    return overVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((OverSeasVC *)viewController).index;
    [self setBtnColor:index];
    
    index--;
    if (index < 0) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((OverSeasVC *)viewController).index;
    [self setBtnColor:index];
    
    index++;
    if (index == _locationArr.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (void)setBtnColor:(NSInteger)index {
    for (UIButton *btn in _btnArr) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    UIButton *btn = _btnArr[index];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
