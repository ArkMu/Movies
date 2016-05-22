//
//  SearchListVC.m
//  Movies
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

//http://api.meituan.com/mmdb/search/integrated/keyword/list.json?keyword=%E9%AD%94%E5%85%BD&stype=-1&refer=2&iscorrected=false&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819294&lng=113.56429&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459938075943&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=d19a8eae-fc93-4bb1-99f6-d89d6be48e33&__skcy=VaFrihwpS1YxwWKV2F8HvxycS7c%3D

#import "SearchListVC.h"

#import "SearchDetailVC.h"

#import "AFHTTPSessionManager.h"

#import "SearchMovieModel.h"
#import "SearchMovieCell.h"

#import "Common.h"

@interface SearchListVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *hotArr;

@property (nonatomic, strong) NSDictionary *typeListDic;

@property (nonatomic, strong) NSDictionary *locationListDic;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *searchArr;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *resultArr;

@end

@implementation SearchListVC

static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _typeListDic = @{@(1):@"剧情", @(2):@"喜剧", @(3):@"爱情", @(4):@"动画", @(5):@"动作", @(6):@"恐怖", @(7):@"惊悚", @(8):@"悬疑", @(9):@"冒险", @(10):@"科幻", @(11):@"犯罪", @(12):@"战争", @(13):@"纪录片", @(100):@"其它"};
    
    _locationListDic = @{@(2):@"大陆", @(3):@"美国", @(4):@"法国", @(5):@"英国", @(6):@"日本", @(7):@"韩国", @(8):@"印度", @(9):@"泰国", @(10):@"港台", @(11):@"德国", @(100):@"其它"};
    
    _searchArr = [NSMutableArray array];
    
    _resultArr = [NSMutableArray array];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.meituan.com/mmdb/search/movie/hotword/list.json?token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819339&lng=113.564432&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459943354790&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=f45a65db-3655-4919-a3ac-beb2f64a1d02&__skcy=AYL94k1UI%2BQLAhbBG9apRgCYRMU%3D" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = (NSDictionary *)responseObject;
        NSArray *resultArr = resultDic[@"data"];
        _hotArr = [NSMutableArray array];
        for (NSDictionary * dict in resultArr) {
            [_hotArr addObject:dict[@"value"]];
        }

        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50, 44)];
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btn addTarget:self action:@selector(actionOnCancelBtnTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionOnBackBtn)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100;
    _tableView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _searchArr.count;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.font = [UIFont systemFontOfSize:13.0];
    
    if (section == 1) {
        label.text = @"  热门搜索";
    }
    if (section == 3) {
        label.text = @"  类型";
    }
    if (section == 2) {
        label.text = @"  地区";
    }
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath == 0) {
        cell.textLabel.text = _searchArr[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.tag = 1;
        
        for (int i = 0; i < _hotArr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100 * i, 0, 80, 20);
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [btn setTitle:_hotArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(actionOnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
        }
    } else if (indexPath.section == 2) {
        cell.tag = 3;
//        NSArray *arr = _typeListDic.allValues;
        [self layoutBtn:_typeListDic section:indexPath.section containerView:cell];
        
    } else {
        cell.tag = 2;
//        NSArray *arr = _locationListDic.allValues;
        [self layoutBtn:_locationListDic section:indexPath.section containerView:cell];
    }
    
    return cell;
}


- (void)layoutBtn:(NSDictionary *)resultDic section:(NSInteger)inter containerView:(UITableViewCell *)tableViewCell{
    
    NSArray *resultArr = resultDic.allKeys;
    for (int i = 0; i < resultArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i < resultArr.count - 1) {
            [btn setTitle:resultDic[@(inter - 1)] forState:UIControlStateNormal];
        } else {
            [btn setTitle:resultDic[@(100)] forState:UIControlStateNormal];
        }
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        btn.tag = inter++;
        
        [btn addTarget:self action:@selector(actionOnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = self.view.frame.size.width / 4;
        CGFloat height = 20;
        btn.frame = CGRectMake(width * (i % 4), 20 * (i / 4), width, height);
        
        [tableViewCell addSubview:btn];
    }
}

- (void)actionOnBtnClick:(UIButton *)sender {
    
    SearchDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SearchDetailVC class])];
    
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    detail.section = cell.tag;
    if (cell.tag == 1) {
        detail.searchStr = [sender currentTitle];
    }
    if (cell.tag == 3) {
        detail.row = sender.tag;
    }
    
    if (cell.tag == 2) {
        detail.row = sender.tag;
    }
    detail.title = [sender currentTitle];
    
    [self.navigationController pushViewController:detail animated:NO];
}

#pragma mark - UISearchBarDelegate

- (void)actionOnBackBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)actionOnCancelBtnTap {
    [self.navigationController popViewControllerAnimated:NO];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    SearchDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetailVC"];
    [self.navigationController pushViewController:detail animated:NO];
    return NO;
}

@end
