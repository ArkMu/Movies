//
//  OverSeasVC.m
//  Movies
//
//  Created by qingyun on 16/4/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

//{
//    "form": "map",
//    "resources": [{
//        "method": "GET",
//        "url": "http://api.maoyan.com/mmdb/movie/oversea/recommend.json?area=JP&token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//        "headers": {
//            "Accept-Charset": "utf-8",
//            "Token": "",
//            "Date": "Tue, 5 Apr 2016 07:14:22 GMT",
//            "Key": "7773764",
//            "Authorization": "630f151f0fe90355db3608da5bb37491"
//        }
//    }, {
//        "method": "GET",
//        "url": "http://api.maoyan.com/mmdb/movie/oversea/coming.json?area=JP&offset=0&limit=10&token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//        "headers": {
//            "Accept-Charset": "utf-8",
//            "Token": "",
//            "Date": "Tue, 5 Apr 2016 07:14:22 GMT",
//            "Key": "95204960",
//            "Authorization": "5b21e39c747f65b26991502c18539d57"
//        }
//    }, {
//        "method": "GET",
//        "url": "http://api.maoyan.com/mmdb/movie/oversea/hot.json?area=JP&offset=0&limit=10&token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD",
//        "headers": {
//            "Accept-Charset": "utf-8",
//            "Token": "",
//            "Date": "Tue, 5 Apr 2016 07:14:22 GMT",
//            "Key": "58148786",
//            "Authorization": "691715ea6ae1c9be4e8a184d52e9a321"
//        }
//    }]
//}



#import "OverSeasVC.h"

#import "AFHTTPSessionManager.h"

#import "HotMovieModel.h"
#import "HotMovieCell.h"
#import "MovieDetailCell.h"

#import "DetailVC.h"

@interface OverSeasVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *overSeasHotArr;  // 海外 热映

@property (nonatomic, strong) NSMutableArray *overSeasComingArr;  //海外 待映

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arr;

@end

@implementation OverSeasVC

static NSString *cellIdentifier = @"cell";
static NSString *hotCellIdentifier = @"hot";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = @[@"NA",@"KR",@"JP"];
    [self loadData];
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameter = @{@"Accept-Charset": @"utf-8",
                                @"Token": @"",
                                @"Date": @"Tue, 5 Apr 2016 07:14:22 GMT",
                                @"Key": @"7773764",
                                @"Authorization": @"630f151f0fe90355db3608da5bb37491"
                                };
    
    [manager GET:@"http://api.maoyan.com/mmdb/movie/oversea/recommend.json?area=JP&token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    // 待映
    NSDictionary *parameter1 = @{@"Accept-Charset": @"utf-8",
                                @"Token": @"",
                                @"Date": @"Tue, 5 Apr 2016 07:14:22 GMT",
                                @"Key": @"95204960",
                                @"Authorization": @"5b21e39c747f65b26991502c18539d57"
                                };
    
    NSString *urlCom = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/oversea/coming.json?area=\%@&offset=0&limit=10&token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _arr[_index]];
    [manager GET:urlCom parameters:parameter1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *arr = resultDict[@"data"][@"coming"];
        
        _overSeasComingArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            HotMovieModel *model = [HotMovieModel modelWithDictionary:dict];
            [_overSeasComingArr addObject:model];
        }
        
        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
    // 热映
    NSDictionary *parameter2 = @{@"Accept-Charset": @"utf-8",
                                 @"Token": @"",
                                 @"Date": @"Tue, 5 Apr 2016 07:14:22 GMT",
                                 @"Key": @"58148786",
                                 @"Authorization": @"691715ea6ae1c9be4e8a184d52e9a321"
                                 };
    
    NSString *urlHot = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/oversea/hot.json?area=\%@&offset=0&limit=10&token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _arr[_index]];
    [manager GET:urlHot parameters:parameter2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *arr = resultDict[@"data"][@"hot"];
        
        _overSeasHotArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            HotMovieModel *model = [HotMovieModel modelWithDictionary:dict];
            [_overSeasHotArr addObject:model];
        }
        
        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
}


- (void)loadTableView {
    if (_tableView) {
        [_tableView reloadData];
        return;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.estimatedRowHeight = 100;
    [self.view addSubview:_tableView];
    
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotMovieCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:hotCellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _overSeasHotArr.count;
    }
    return _overSeasComingArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HotMovieModel *model = _overSeasHotArr[indexPath.row];
        HotMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:hotCellIdentifier];
        cell.model = model;
        return cell;
    }
    
    HotMovieModel *model = _overSeasComingArr[indexPath.row];
    MovieDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.4 alpha:0.7];
    label.font = [UIFont systemFontOfSize:13.0];
    
    if (section == 0) {
        label.text = @"   热映";
        return label;
    }
    
    label.text = @"   待映";
    return label;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailVC class])];
    
    if (indexPath.section == 0) {
        HotMovieModel *model = _overSeasHotArr[indexPath.row];
        detail.Id = model.Id;
    } else {
        HotMovieModel *model = _overSeasComingArr[indexPath.row];
        detail.Id = model.Id;
    }
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
