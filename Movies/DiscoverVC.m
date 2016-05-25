//
//  DiscoverVC.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DiscoverVC.h"

#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "Reachability.h"

#import "Common.h"

#import "ScrollViewModel.h"
#import "ScrollViewCell.h"

#import "WebVC.h"

#import "FooterModel.h"
#import "FooterView.h"

#import "FeedsModel.h"
#import "FeedsCell.h"

#import "FeedsOneCell.h"

@interface DiscoverVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *scrollViewArr;

@property (nonatomic, strong) NSMutableArray *footViewArr;

@property (nonatomic, strong) NSMutableArray *feedCellArr;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger pagrIndex;

@property (nonatomic, assign) NSInteger netReached;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation DiscoverVC

static NSString *scrollViewIdentifier = @"scroll";
static NSString *footViewIdentifier = @"footer";
static NSString *cellIdentifier = @"cell";
static NSString *oneImgIdentifier = @"one";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _manager = [AFHTTPSessionManager manager];
    
    self.navigationItem.title = @"发现";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 104) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate =  self;
    _tableView.estimatedRowHeight = 100;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ScrollViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:scrollViewIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:footViewIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FeedsCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FeedsOneCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:oneImgIdentifier];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pagrIndex = 0;
        _netReached = 0;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadScollViewData];
            _feedCellArr = [NSMutableArray array];
            [self loadDetailData];
        });
        
        
        
//        dispatch_queue_t queue = dispatch_queue_create("lxz", DISPATCH_QUEUE_SERIAL);
//        
//        dispatch_sync(queue, ^{
//            [self loadScollViewData];
//            _feedCellArr = [NSMutableArray array];
//            [self loadDetailData];
//            if ([_tableView.mj_header isRefreshing]) {
//                [_tableView.mj_header endRefreshing];
//            }
//        });
        
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
}

- (void)reloadTableView {
    if (_netReached == 2) {
        [_tableView reloadData];
        [_timer invalidate];
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    }
    
}



-(void)viewWillAppear:(BOOL)animated {
    _netReached = 0;
    Reachability *reach = [Reachability reachabilityForInternetConnection];

    if (![reach currentReachabilityStatus]) {
        [SVProgressHUD showInfoWithStatus:@"网络状况不佳"];
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    } else {
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pagrIndex++;
            [self loadDetailData];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)loadScollViewData {
    
    
    //获取顶部scrollview
    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
                                @"Connection":@"Keep-Alive",
                                @"Accept-Encoding":@"gzip",
                                @"__skcy":@"aUQRNUJ1iVKeLSF4a0UR9fl1IEk=",
                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
                                @"__skno":@"eccb655f-e29e-4396-a520-9997ffd053a1",
                                @"_skck":@"6a375bce8c66a0dc293860dfa83833ef",
                                @"__skts":@"1459648947046",
                                @"User_Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy"};
    
    [_manager GET:@"http://advert.mobile.meituan.com/api/v3/adverts?cityid=73&category=14&version=6.6.0&new=0&app=movie&clienttp=android&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&devid=353617055672400&uid=&movieid=&partner=1&apptype=1&smId=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&lat=34.819319&lng=113.564281" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSArray *arr = resultDict[@"data"];
        
        _scrollViewArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            ScrollViewModel *model = [ScrollViewModel modelWithDictionary:dict];
            [_scrollViewArr addObject:model];
        }
        
        _netReached++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    }];
    
    // 获取4个btn
//    
//    [_manager GET:@"http://api.meituan.com/sns/v2/buttons.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819315&lng=113.564332" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSDictionary *resultDict = (NSDictionary *)responseObject;
//        NSArray *arr = resultDict[@"data"];
//        
//        _footViewArr = [NSMutableArray array];
//        for (NSDictionary *dict in arr) {
//            FooterModel *model = [FooterModel modelWithDictionary:dict];
//            [_footViewArr addObject:model];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
    
    
    
}

- (void)loadDetailData {
    // 获取details
    
    NSDictionary *parameter = @{@"offset":@(_pagrIndex * 10)};
    
    [_manager GET:@"http://api.meituan.com/sns/v1/feed.json?limit=10&timestamp=0&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819208&lng=113.564376" parameters:parameter
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *arr = resultDict[@"data"][@"feeds"];
        
        
        for (NSDictionary *dict in arr) {
            FeedsModel *model = [FeedsModel modelWithDictionary: dict];
            [_feedCellArr addObject:model];
        }
             _netReached++;
             [_tableView reloadData];
             if ([_tableView.mj_footer isRefreshing]) {
                 [_tableView.mj_footer endRefreshing];
             }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return _feedCellArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 150;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return 100;
//    }
//    
//    return 0.01;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30;
    }
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
        label.text = @"今天";
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        return label;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollViewIdentifier forIndexPath:indexPath];
        cell.gotoWebView = ^(NSString *url) {
            WebVC *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
            web.urlStr = url;
            
            [self.navigationController pushViewController:web animated:YES];
        };
        cell.modelArr = _scrollViewArr;
        
        [NSTimer scheduledTimerWithTimeInterval:1.f target:cell selector:cell.updateImageMethod userInfo:nil repeats:YES];
        
        return cell;
    }
    
    FeedsModel *model = _feedCellArr[indexPath.row];
    if (model.imageArr.count < 3) {
        FeedsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:oneImgIdentifier];
        cell.model = model;
        return cell;
    }
    
    FeedsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = _feedCellArr[indexPath.row];
    return cell;
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section == 1) {
//        return nil;
//    }
//    FooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footViewIdentifier];
//    view.modelArr = _footViewArr;
//    view.gotoWebView = ^(NSString *url) {
//        WebVC *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
//        
//        NSString *regExString = @"url=.*";
//        NSError *error = nil;
//        NSRegularExpression *regularExpressioin = [NSRegularExpression regularExpressionWithPattern:regExString options:NSRegularExpressionCaseInsensitive error:&error];
//        
//        NSTextCheckingResult *result = [regularExpressioin firstMatchInString:url options:NSMatchingReportProgress range:NSMakeRange(0, url.length)];
//        if (result) {
//            NSRange resultRange = result.range;
//            NSString *resultString = [url substringWithRange:NSMakeRange(resultRange.location + 4, resultRange.length- 4)];
//        
//            NSString *urlString= [resultString stringByRemovingPercentEncoding];
//        
//            web.urlStr = urlString;
//        }
//        
//
//        
//        [self.navigationController pushViewController:web animated:NO];
//    };
//    return view;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
