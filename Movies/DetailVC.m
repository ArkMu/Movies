//
//  DetailVC.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailVC.h"

#import "AFHTTPSessionManager.h"
#import "Masonry/Masonry.h"

#import "MovieModel.h"
#import "ActorModel.h"

#import "DetailHeaderView.h"

#import "ActorInfoBtnV.h"

#import "HcmtModel.h"
#import "HcmtCell.h"

#import "FilmReviewsModel.h"
#import "FilmReviewsCell.h"

@interface DetailVC () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MovieModel *MModel;

@property (nonatomic, strong) NSMutableArray *AMArr; // actor array

@property (nonatomic, strong) NSMutableArray *HcmtArr; //  短评

@property (nonatomic, strong) NSMutableArray *filmArr; // 长评论

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DetailVC

static NSString *headerIdentifier = @"header";
static NSString *cellIdentifier = @"cell";

static NSString *hcmtIdentifier = @"hcmt";
static NSString *filmIdentifier = @"film";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    NSDictionary *parameter = @{
//                                @"Host":@"api.meituan.com",
//                                @"Connection":@"Keep-Alive",
//                                @"Accept-Encoding":@"gzip",
//                                @"__skcy":@"aUQRNUJ1iVKeLSF4a0UR9fl1IEk=",
//                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                @"__skno":@"eccb655f-e29e-4396-a520-9997ffd053a1",
//                                @"_skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                @"__skts":@"1459648947046",
//                                @"User_Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy",
//                                @"form": @"map",
//                                @"resources": @[ @{
//                                                     @"method": @"GET",
//                                                     @"url": @"http://api.maoyan.com/mmdb/movie/v5/246286.json?token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//                                                     @"headers": @{}
//                                                     }, @{
//                                                     @"method": @"GET",
//                                                     @"url": @"http://api.maoyan.com/mmdb/v7/movie/246286/celebrities.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//                                                     @"headers": @{}
//                                                     }, @{
//                                                     @"method": @"GET",
//                                                     @"url": @"http://api.maoyan.com/mmdb/comments/major/info/246286.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//                                                     @"headers": @{}
//                                                     }, @{
//                                                     @"method": @"GET",
//                                                     @"url": @"http://api.maoyan.com/mallpro/movieDeal.json?movieId=246286&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//                                                     @"headers": @{
//                                                             @"Accept-Charset": @"utf-8",
//                                                             @"Token": @"",
//                                                             @"Date": @"Sun, 3 Apr 2016 05:19:29 GMT",
//                                                             @"Key": @"13648495",
//                                                             @"Authorization": @"1940142b5402997f49c567535a3d330c"
//                                                             }
//                                                     }]
//                                };
    
//    NSDictionary *parameter = @{}
    
//    [manager POST:@"http://api.meituan.com/combo/v2/combo.json?__vhost=api.mobile.meituan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819302&lng=113.564253" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    
    // get movie info
    
    NSString *movieInfoUrl = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/\%ld.json?token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    
    [manager GET:movieInfoUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        _MModel = [MovieModel modelWithDictionary:dict[@"data"][@"movie"]];
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    // get actor info
    
    NSString *actorUrl = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v7/movie/\%ld/celebrities.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    [manager GET:actorUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *resultArr = dict[@"data"];
        NSLog(@"%@", resultArr);
        
        _AMArr = [NSMutableArray array];
        for (NSArray *arr in resultArr) {
            NSMutableArray *marr = [NSMutableArray array];
            for (NSDictionary *dict in arr) {
                ActorModel *model = [ActorModel modelWithDictionary:dict];
                [marr addObject:model];
            }
            [_AMArr addObject:marr];
        }

        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    // 获取短评论
    
    NSString *hcmtUrl = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/comments/movie/v2/\%ld.json?token=&offset=0&limit=15&tag=0&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    [manager GET:hcmtUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *arr = dict[@"hcmts"];
        
        _HcmtArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            HcmtModel *model = [HcmtModel modelWithDictionary:dict];
            [_HcmtArr addObject:model];
            
            // 插入数据库;
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    // 获取长评论
    NSString *filmUrl = [NSString stringWithFormat:@"http://api.maoyan.com/sns/movie/\%ld/filmReview/top.json?token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    
    [manager GET:filmUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *arr =  dict[@"data"][@"filmReviews"];
        
        _filmArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            FilmReviewsModel *model = [FilmReviewsModel modelWithDictionary:dict];
            [_filmArr addObject:model];
        }
        
        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
//    [manager GET:@"http://api.maoyan.com/mmdb/comments/major/info/246286.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
//    
//    NSDictionary *parameter = @{@"Accept-Charset": @"utf-8",
//                                @"Token": @"",
//                                @"Date": @"Sun, 3 Apr 2016 05:19:29 GMT",
//                                @"Key": @"13648495",
//                                @"Authorization": @"1940142b5402997f49c567535a3d330c"
//                                };
//    
//    [manager GET:@"http://api.maoyan.com/mallpro/movieDeal.json?movieId=246286&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    DetailHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DetailHeaderView class]) owner:nil options:nil][0];
    headerView.model = _MModel;
//    headerView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    _tableView.tableHeaderView = headerView;
    _tableView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    
    _tableView.rowHeight = 120;
    
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HcmtCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:hcmtIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FilmReviewsCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:filmIdentifier];
}



#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", (long)section);
    if (section == 2) {
        return _HcmtArr.count;
    }
    if (section == 3) {
        return _filmArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.textLabel.text = _MModel.dra;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont italicSystemFontOfSize:13.0];
        return cell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        // 求所有元素的个数
        NSInteger count = 0;
        NSMutableArray *actorDetailArr = [NSMutableArray array];
        for (NSArray *arr in _AMArr) {
            for (ActorModel *model in arr) {
                count++;
                [actorDetailArr addObject:model];
            }
        }
        
        // 间距: 5 宽: 75
        NSLog(@"%ld", 75 * count);
        scrollView.contentSize = CGSizeMake(75 * count, 100.0);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75 * count, 100)];
        [scrollView addSubview:view];
        scrollView.delegate = self;
        
        for (int i = 0; i < count; i++) {
            ActorInfoBtnV *btn = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ActorInfoBtnV class]) owner:nil options:nil][0];
            btn.model = actorDetailArr[i];
            btn.frame = CGRectMake(80 * i + 5, 0, 75, 100);
            [view addSubview:btn];
            
        }
        [cell.contentView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(cell);
            make.size.mas_equalTo(cell);
        }];
        return cell;
    }
    
    if (indexPath.section == 2) {
        HcmtCell *cell = [tableView dequeueReusableCellWithIdentifier:hcmtIdentifier];
        cell.model = _HcmtArr[indexPath.row];
        return cell;
    }
   
//    if (indexPath.section == 3) {
        FilmReviewsCell *cell = [tableView dequeueReusableCellWithIdentifier:filmIdentifier];
        cell.model = _filmArr[indexPath.row];
        return cell;
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 40;
    }
    return 0.01;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return @"短评";
    }
    if (section == 3) {
        return @"长评";
    }
    return nil;
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
