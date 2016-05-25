//
//  ViewController.m
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotMovieVC.h"

#import "AFHTTPSessionManager.h"
#import "FMDBShare.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "Reachability.h"

#import "HotMovieModel.h"
#import "HotMovieCell.h"

#import "DetailVC.h"

#import "SearchListVC.h"

@interface HotMovieVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HotMovieVC

static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"热映";
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon_search@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionOnSearch)];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 24) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotMovieCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        _pageIndex = 0;
        _listArr = [NSMutableArray array];
        [self loadData];
    }];

    [_tableView.mj_header beginRefreshing];
    
    _manager = [AFHTTPSessionManager manager];
    
}

- (void)loadData {
    
    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
                                @"Connection":@"Keep-Alive",
                                @"Accept-Encoding":@"gzip",
                                @"__skcy":@"aUQRNUJ1iVKeLSF4a0UR9fl1IEk=",
                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
                                @"__skno":@"eccb655f-e29e-4396-a520-9997ffd053a1",
                                @"_skck":@"6a375bce8c66a0dc293860dfa83833ef",
                                @"__skts":@"1459648947046",
                                @"User_Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy",
                                @"offset":@(_pageIndex * 12)};
    
    [_manager GET:@"http://api.meituan.com/mmdb/movie/v2/list/hot.json?order=show_desc&ct=%E9%83%91%E5%B7%9E&limit=12&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieC110189035496448D-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819273&lng=113.564393" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *hotArr = responseObject[@"data"][@"hot"];
        if (!hotArr.count) {
            _tableView.mj_footer.state = MJRefreshStateNoMoreData;
            return;
        }
        
        for (NSDictionary *dict in hotArr) {
            HotMovieModel *model = [HotMovieModel modelWithDictionary:dict];
            [_listArr addObject:model];
        }
        
        [self.tableView reloadData];
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"网络状况不佳"];
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if (![reach currentReachabilityStatus]) {
        [SVProgressHUD showInfoWithStatus:@"网络状况不佳"];
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    } else {
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex++;
            [self loadData];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    HotMovieModel *model = _listArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailVC class])];
    HotMovieModel *model = _listArr[indexPath.row];
    detail.Id = model.Id;
    detail.movieName = model.nm;
    
    [self.navigationController pushViewController:detail animated:NO];
}


- (void)actionOnSearch {
    SearchListVC *list = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchListVC"];
    
    [self.navigationController pushViewController:list animated:NO];
}

@end
