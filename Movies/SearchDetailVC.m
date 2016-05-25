//
//  SearchDetailVC.m
//  Movies
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SearchDetailVC.h"

#import "AFHTTPSessionManager.h"

#import "SearchMovieModel.h"
#import "SearchMovieCell.h"

#import "DetailVC.h"

@interface SearchDetailVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *resultArr;

@property (nonatomic, strong) UISearchBar *searchBar ;

@end

@implementation SearchDetailVC

static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = _searchBar;
    [_searchBar becomeFirstResponder];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionOnBackBtn)];
    
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"charset=UTF-8", nil];
    
    _resultArr = [NSMutableArray array];
    
    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
                                @"Connection":@"Keep-Alive",
                                @"Content-Type":@"application/json;charse=UTF-8",
                                @"Accept-Encoding":@"gzip",
                                @"__skcy":@"9I6Zq0K0OPwzuwnheP1GWkOrA2s=",
                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
                                @"__skno":@"bf67ec63-2586-4e5a-9cc4-120c758dc137",
                                @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
                                @"__skts":@"1460003896416",
                                @"User-Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy"
                                };
    
    if (_section == 1) {
        
        NSString *str = [NSString stringWithFormat:@"http://api.meituan.com/mmdb/search/integrated/keyword/list.json?keyword=\%@&stype=-1&refer=3&iscorrected=false&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819283&lng=113.564313", _searchStr];
        
        NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        // 疯狂动物城
//        NSDictionary *parameter = @{@"__skcy":@"Eu9xrVkl9ClSgTzEa0iyaTE8Swo=",
//                                    @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                    @"__skno":@"8f5dbc30-a288-45df-89ca-d1c3bf211583",
//                                    @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                    @"__skts":@"1460000208859"
//                                    };
        
        //死侍
//        NSDictionary *parameter1 = @{@"__skcy":@"GQbGXm0AMvSy7DussgXJupX1Hf8=",
//                                     @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                     @"__skno":@"59f6b36b-c69c-4b4b-a908-c8b2bab994d7",
//                                     @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                     @"__skts":@"1460000135455"
//                                     };
//        // 魔兽
//        NSDictionary *parameter2 = @{@"__skcy":@"T5qYs7wqeOjys34PUsT92TtmuDw=",
//                                     @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                     @"__skno":@"793a3291-d15d-4959-8ab9-c987907fa897",
//                                     @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                     @"__skts":@"1460000541830"
//                                     };
        
        NSString *str2;
        if ([_searchStr isEqualToString:@"魔兽"]) {
            str2 = @"&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459947396764&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=8182dc60-890b-4fca-80f4-92dae1ce9a35&__skcy=v30a%2BsTlpQgMHc8QfBIptSw9HOw%3D";
            
        } else if ([_searchStr isEqualToString:@"死侍"]) {
            str2 = @"&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460000861270&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=7bb7107a-2fd5-4ef8-9b10-797f2e518c46&__skcy=jbJaF8hyXLKgzaUPdDeN6lgaeaI%3D";
        } else {
            str2 = @"&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460000901596&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=4adef29f-c1f6-4523-956b-55170db16e5f&__skcy=cmQMrFeK2%2FcDiPptJptHEo1GbP8%3D";
        }
       
        
        NSString *url = [str1 stringByAppendingString:str2];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            NSDictionary *resultDict = (NSDictionary *)responseObject;
//            NSArray *resultArr = resultDict[@"data"][@"list"];
            NSArray *arr = resultDict[@"data"];
            NSArray *result = arr[0][@"list"];
            
            for (NSDictionary *dict in result) {
                SearchMovieModel *model = [SearchMovieModel modelWithDictionary:dict];
                [_resultArr addObject:model];
            }

            [self loadTableView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
    }
    
    
    if (_section == 3) {
        
//        http://api.meituan.com/mmdb/search/movie/category/list.json?cityId=73&tp=3&cat=4&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819319&lng=113.564324&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459995027680&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=ffa08525-e11e-4c4e-9eab-d30eb9303fc0&__skcy=Jhb3y3GIeZkuUpQUZTLdWCAkk3g%3D
        
        NSString *str1 = [NSString stringWithFormat:@"http://api.meituan.com/mmdb/search/movie/category/list.json?cityId=73&tp=\%ld&cat=\%ld&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819319&lng=113.564324", _section, _row];
        
        NSString *str2 = @"&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459995027680&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=ffa08525-e11e-4c4e-9eab-d30eb9303fc0&__skcy=Jhb3y3GIeZkuUpQUZTLdWCAkk3g%3D";
        
        NSString *url = [str1 stringByAppendingString:str2];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            
            NSDictionary *resultDict = (NSDictionary *)responseObject;
            //            NSArray *resultArr = resultDict[@"data"][@"list"];
            NSArray *arr = resultDict[@"list"];
            
            _resultArr = [NSMutableArray array];
            for (NSDictionary *dict in arr) {
                SearchMovieModel *model = [SearchMovieModel modelWithDictionary:dict];
                [_resultArr addObject:model];
            }
            
            [self loadTableView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
    }
    
    if (_section == 2) {
        
//http://api.meituan.com/mmdb/search/movie/source/list.json?cityId=73&tp=2&src=3&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819283&lng=113.564313&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459947222338&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=099094fb-9431-4a08-b93d-139607a41b75&__skcy=Hhrm8sIFiwqhl36CNpWOtoRyFM0%3D
      
        
        NSString *str = [NSString stringWithFormat:@"http://api.meituan.com/mmdb/search/movie/source/list.json?cityId=73&tp=\%ld&src=\%ld&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819283&lng=113.564313", _section, _row];
        
        NSString *str1 = @"&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459947222338&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=099094fb-9431-4a08-b93d-139607a41b75&__skcy=Hhrm8sIFiwqhl36CNpWOtoRyFM0%3D";
        
        NSString *url = [str stringByAppendingString:str1];
        
        
        
        [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            
            NSDictionary *resultDict = (NSDictionary *)responseObject;
            //            NSArray *resultArr = resultDict[@"data"][@"list"];
            NSArray *arr = resultDict[@"list"];
//            NSArray *result = arr[0][@"list"];
            
            _resultArr = [NSMutableArray array];
            for (NSDictionary *dict in arr) {
                SearchMovieModel *model = [SearchMovieModel modelWithDictionary:dict];
                [_resultArr addObject:model];
            }

            
            [self loadTableView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
        
        
    }
    
}

// 剧情
//http://api.meituan.com/mmdb/search/movie/category/list.json?cityId=73&tp=3&cat=1&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819314&lng=113.564327&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460002413611&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=763f0abd-8c23-4207-b49b-df773c489960&__skcy=0fMP93rxQQv4%2F%2B0fP18yHP8IwdQ%3D

//美国
//http://api.meituan.com/mmdb/search/movie/source/list.json?cityId=73&tp=2&src=3&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819319&lng=113.564324&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460001804279&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=9288fdb2-0aef-49e9-a667-867d76781c75&__skcy=ZxeQxY6ApsnjYmkx%2Blrp40MFeC0%3D

// 美国
//http://api.meituan.com/mmdb/search/movie/source/list.json?cityId=73&tp=2&src=3&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819212&lng=113.564249&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460003917532&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=e50fc458-6a27-4a79-a9c9-ad6fe426841e&__skcy=hiuyz3Z2ia81G2QKN4Pomv6BmdA%3D


// 法国
//http://api.meituan.com/mmdb/search/movie/source/list.json?cityId=73&tp=2&src=4&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819319&lng=113.564324&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460001863907&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=27a319ad-3f66-41a5-93df-7f80fab1ecd8&__skcy=LhtRuETELYZjwskyXgGcHOkXRDU%3D

// 印度
//http://api.meituan.com/mmdb/search/movie/source/list.json?cityId=73&tp=2&src=8&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819314&lng=113.564327&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460002040663&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=b1ccfb50-06f4-4c4b-a29c-27a1a93f99dd&__skcy=vvZMYP9DTdKYGkoDJUzcLAL5yDY%3D


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];

    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchMovieCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = _resultArr[indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    SearchMovieModel *model = _resultArr[indexPath.row];
    detail.Id = model.Id;
    detail.movieName = model.nm;
    
    [self.navigationController pushViewController:detail animated:NO];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:NO];
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
//                                @"Connection":@"Keep-Alive",
//                                //                                @"Content-Type":@"application/json;charse=UTF-8",
//                                @"Accept-Encoding":@"gzip",
//                                @"__skcy":@"9I6Zq0K0OPwzuwnheP1GWkOrA2s=",
//                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                @"__skno":@"bf67ec63-2586-4e5a-9cc4-120c758dc137",
//                                @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                @"__skts":@"1460003896416",
//                                @"User-Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy"
//                                };
//    
//    NSString *str = [NSString stringWithFormat:@"http://api.meituan.com/mmdb/search/integrated/keyword/list.json?keyword=\%@&stype=-1&refer=3&iscorrected=false&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819283&lng=113.564313", _searchStr];
//    
//    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    
//    [manager GET:str1 parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//        
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
//}

- (void)actionOnBackBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (_searchBar.text.length == 0) {
        return;
    }
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    
        NSString *str = [NSString stringWithFormat:@"http://api.meituan.com/mmdb/search/integrated/keyword/list.json?keyword=\%@&stype=-1&refer=1&iscorrected=false&limit=10&offset=0&token=&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=0&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819328&lng=113.564276",_searchBar.text];
    
    
        NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
//        NSString *str2 = [str stringByAppendingString:@"&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1460037176796&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=6478cbce-cbdb-4891-ae32-be6e988cd459&__skcy=iazvqXeSMkphadlRPaDWbDCfN1k%3D"];
    
        [manager GET:str1 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            NSDictionary *resultDict = (NSDictionary *)responseObject;
            NSArray *arr = resultDict[@"data"];
            NSArray *arr1 = arr[0][@"list"];
            [_resultArr removeAllObjects];
            for (NSDictionary *dict in arr1) {
                SearchMovieModel *model = [SearchMovieModel modelWithDictionary:dict];
                [_resultArr addObject:model];
            }
            
            [self loadTableView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];
}


@end
