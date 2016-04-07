//
//  DiscoverVC.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DiscoverVC.h"

#import "AFHTTPSessionManager.h"

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

@end

@implementation DiscoverVC

static NSString *scrollViewIdentifier = @"scroll";
static NSString *footViewIdentifier = @"footer";
static NSString *cellIdentifier = @"cell";
static NSString *oneImgIdentifier = @"one";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.translucent = NO;
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
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
    
    [manager GET:@"http://advert.mobile.meituan.com/api/v3/adverts?cityid=73&category=14&version=6.6.0&new=0&app=movie&clienttp=android&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&devid=353617055672400&uid=&movieid=&partner=1&apptype=1&smId=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&lat=34.819319&lng=113.564281" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSArray *arr = resultDict[@"data"];
        
        _scrollViewArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            ScrollViewModel *model = [ScrollViewModel modelWithDictionary:dict];
            [_scrollViewArr addObject:model];
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    // 获取4个btn
    
    [manager GET:@"http://api.meituan.com/sns/v2/buttons.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819315&lng=113.564332" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSArray *arr = resultDict[@"data"];
        
        _footViewArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            FooterModel *model = [FooterModel modelWithDictionary:dict];
            [_footViewArr addObject:model];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
    // 获取details
    
    [manager GET:@"http://api.meituan.com/sns/v1/feed.json?offset=0&limit=10&timestamp=0&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819208&lng=113.564376" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *arr = resultDict[@"data"][@"feeds"];
        _feedCellArr = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            FeedsModel *model = [FeedsModel modelWithDictionary: dict];
            [_feedCellArr addObject:model];
        }
        
        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate =  self;
    _tableView.estimatedRowHeight = 100;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ScrollViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:scrollViewIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:footViewIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FeedsCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FeedsOneCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:oneImgIdentifier];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    
    return 0.01;
}

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return nil;
    }
    FooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footViewIdentifier];
    view.modelArr = _footViewArr;
    view.gotoWebView = ^(NSString *url) {
        WebVC *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
        
        NSString *regExString = @"url=.*";
        NSError *error = nil;
        NSRegularExpression *regularExpressioin = [NSRegularExpression regularExpressionWithPattern:regExString options:NSRegularExpressionCaseInsensitive error:&error];
        
        NSTextCheckingResult *result = [regularExpressioin firstMatchInString:url options:NSMatchingReportProgress range:NSMakeRange(0, url.length)];
        if (result) {
            NSRange resultRange = result.range;
            NSString *resultString = [url substringWithRange:NSMakeRange(resultRange.location + 4, resultRange.length- 4)];
        
            NSString *urlString= [resultString stringByRemovingPercentEncoding];
        
            web.urlStr = urlString;
        }
        

        
        [self.navigationController pushViewController:web animated:NO];
    };
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
