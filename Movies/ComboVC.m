//
//  ComboVC.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ComboVC.h"

#import "ListModel.h"

#import "ComingModel.h"
#import "HotMovieModel.h"
#import "ComMovieView.h"

//#import "HotMovieCell.h"
#import "MovieDetailCell.h"

#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "Reachability.h"

#import "DetailVC.h"

#import "MoviePlayerVC.h"

@interface ComboVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSMutableArray *commingMovieArr;

@property (nonatomic, strong) NSMutableArray *movieArr;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, assign) NSInteger netReached;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ComboVC

static NSString *cellIdentifier = @"cell";
static NSString *movieIdentidier = @"movie";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"待映";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:movieIdentidier];
    
    _manager = [AFHTTPSessionManager manager];
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 0;
        _netReached = 0;
        _movieArr = [NSMutableArray array];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadComingData];
            [self loadListData];
            [self loadMoreData];
        });
        
    }];
    
    
    [_tableView.mj_header beginRefreshing];
    
    
    
    self.navigationController.navigationBar.translucent = NO;
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

            [self loadMoreData];
        }];
    }
    
    _netReached = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
}

- (void)reloadTableView {
    if (_netReached == 3) {
        [_tableView reloadData];
        [_timer invalidate];
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadListData {
    [_manager GET:@"http://api.maoyan.com/mmdb/movie/lp/list.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *data = resultDict[@"data"];
        
        _listArr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            ListModel *model = [ListModel modelWithDictionary:dict];
            [_listArr addObject:model];
        }
        
        _netReached++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
}


- (void)loadComingData {
    [_manager GET:@"http://api.maoyan.com/mmdb/movie/v1/list/wish/order/coming.json?offset=0&limit=50&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = (NSDictionary *)responseObject;
        
        NSArray *data = result[@"data"][@"coming"];
        
        _commingMovieArr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            ComingModel *model = [ComingModel modelWithDictionary:dict];
            [_commingMovieArr addObject:model];
        }
        
        _netReached++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)loadMoreData {
    
    NSDictionary *parameter = @{@"offset":@(_pageIndex * 12)};
    
    [_manager GET:@"http://api.meituan.com/mmdb/movie/v1/list/rt/order/coming.json?ct=%E9%83%91%E5%B7%9E&limit=12&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819287&lng=113.564373" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = (NSDictionary *)responseObject;
        
        NSArray *data = result[@"data"][@"coming"];
        
        for (NSDictionary *dict in data) {
            HotMovieModel *model = [HotMovieModel modelWithDictionary:dict];
            [_movieArr addObject:model];
        }
        
        _netReached++;
        [_tableView reloadData];
        
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    
    return _movieArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100.f;
    }
    return 150.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                [view removeFromSuperview];
            }
        }
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:cell.bounds];
        
        NSInteger count = _listArr.count;
        
        scrollView.contentSize = CGSizeMake(165 * count + 15, 100);
        scrollView.showsHorizontalScrollIndicator = NO;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 165 * count + 15, 100)];
        [scrollView addSubview:view];
        scrollView.delegate = self;
        
        for (int i = 0; i < count; i++) {
            ListModel *model = _listArr[i];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(165 * i + 15, 0, 150, 100)];
            
            [view addSubview:imgView];
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];

            
            UILabel *movieNameLabel = [[UILabel alloc] init];
            movieNameLabel.text = model.movieName;
            movieNameLabel.textColor = [UIColor blackColor];
            movieNameLabel.font = [UIFont boldSystemFontOfSize:12.0];
            movieNameLabel.textColor = [UIColor whiteColor];
            [imgView addSubview:movieNameLabel];
            
            UILabel *originName = [[UILabel alloc] init];
            originName.text = model.originName;
            originName.textColor = [UIColor blackColor];
            originName.font = [UIFont boldSystemFontOfSize:12.0];
            originName.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
            [imgView addSubview:originName];
            
            [originName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(4);
                make.trailing.mas_equalTo(4);
                make.bottom.mas_equalTo(-4);
            }];
            
            [movieNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(4);
                make.trailing.mas_equalTo(20);
                make.bottom.mas_equalTo(originName.mas_top).with.offset(-4);
            }];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionOnListBtnTap:)];
            [imgView addGestureRecognizer:tap];
            imgView.userInteractionEnabled = YES;
        }
        
        
        [cell.contentView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(cell);
            make.size.mas_equalTo(cell);
        }];
        
        return cell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                [view removeFromSuperview];
            }
        }
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        NSInteger count = _commingMovieArr.count;
        // 85 * 150  15
        scrollView.contentSize = CGSizeMake(100 * count + 15 , 150);
        scrollView.showsHorizontalScrollIndicator = NO;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100 * count + 15, 150)];
        [scrollView addSubview:view];
        scrollView.delegate = self;
        
        for (int i = 0; i < count; i++) {
            ComMovieView *CView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ComMovieView class]) owner:nil options:nil][0];
            CView.model = _commingMovieArr[i];
            CView.frame = CGRectMake(100 * i + 15, 0, 85, 150);
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionOnComMovieBtnTap:)];
            [CView addGestureRecognizer:tap];
            CView.userInteractionEnabled = YES;
            
            [view addSubview:CView];
        }
        //scrollView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(cell);
            make.size.mas_equalTo(cell);
        }];
        return cell;
    }
    
    MovieDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:movieIdentidier];
    
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view removeFromSuperview];
        }
    }
    
    cell.model = _movieArr[indexPath.row];
    return cell;
}

// list的点击事件
- (void)actionOnListBtnTap:(UITapGestureRecognizer *)tap {
//    http://v.meituan.net/movie/videos/5cb17cd6b8c6467ebd6cf89216d0cfd4.mp4
    
    MoviePlayerVC *player = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MoviePlayerVC class])];
    
    UIImageView *imgView = (UIImageView *)tap.view;
    NSInteger inter = (imgView.frame.origin.x - 15) / 165;
    
    ListModel *model = _listArr[inter];
    player.videoUrl = model.url;
    player.movieId = model.movieId;
    player.movieName = model.movieName;
    
    [self.navigationController pushViewController:player animated:YES];
}



// commovie 的点击事件
- (void)actionOnComMovieBtnTap:(UITapGestureRecognizer *)tap {
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    
    ComMovieView *view = (ComMovieView *)tap.view;
    detail.Id = view.model.Id;
    detail.movieName = view.model.nm;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotMovieModel *model = _movieArr[indexPath.row];
    
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailVC class])];
    detail.Id = model.Id;
    detail.movieName = model.nm;
    
    [self.navigationController pushViewController:detail animated:YES];
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
