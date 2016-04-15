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

#import "DetailVC.h"

#import "MoviePlayerVC.h"

@interface ComboVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSMutableArray *commingMovieArr;

@property (nonatomic, strong) NSMutableArray *movieArr;

@end

@implementation ComboVC

static NSString *cellIdentifier = @"cell";
static NSString *movieIdentidier = @"movie";

- (void)viewDidLoad {
    [super viewDidLoad];
       
    [self loadData];
    
    self.navigationController.navigationBar.translucent = NO;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon_search@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionOnBackBarBtnTaped)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.maoyan.com/mmdb/movie/lp/list.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *data = resultDict[@"data"];
        
        _listArr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            ListModel *model = [ListModel modelWithDictionary:dict];
            [_listArr addObject:model];
        }
        
        [self loadTableView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    [manager GET:@"http://api.maoyan.com/mmdb/movie/v1/list/wish/order/coming.json?offset=0&limit=50&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *result = (NSDictionary *)responseObject;
        
        NSArray *data = result[@"data"][@"coming"];
        
        _commingMovieArr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            ComingModel *model = [ComingModel modelWithDictionary:dict];
            [_commingMovieArr addObject:model];
        }
        
        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
                                @"Connection":@"Keep-Alive",
                                @"Accept-Encoding":@"gzip",
                                @"__skcy":@"aUQRNUJ1iVKeLSF4a0UR9fl1IEk=",
                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
                                @"__skno":@"eccb655f-e29e-4396-a520-9997ffd053a1",
                                @"_skck":@"6a375bce8c66a0dc293860dfa83833ef",
                                @"__skts":@"1459648947046",
                                @"User_Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy"};
    
//    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
//                                @"Connection":@"Keep-Alive",
//                                @"Accept-Encoding":@"gzip",
//                                @"__skcy":@"eU+3ycPPOaBLhzTTVOGEJv3LCbc=",
//                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                @"__skno":@"5c88d754-b1b0-4e5d-bc79-f172499a7e0f",
//                                @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                @"__skts":@"1459768174655",
//                                @"User-Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy"
//                                };
    
    [manager GET:@"http://api.meituan.com/mmdb/movie/v1/list/rt/order/coming.json?ct=%E9%83%91%E5%B7%9E&offset=0&limit=12&__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819287&lng=113.564373" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *result = (NSDictionary *)responseObject;
        
        NSArray *data = result[@"data"][@"coming"];
        
        _movieArr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            HotMovieModel *model = [HotMovieModel modelWithDictionary:dict];
            [_movieArr addObject:model];
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
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDetailCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:movieIdentidier];
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
        return 100;
    } else if (indexPath.section == 1) {
        return 150;
    }
    return 200;
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
    
    [self.navigationController pushViewController:player animated:YES];
}



// commovie 的点击事件
- (void)actionOnComMovieBtnTap:(UITapGestureRecognizer *)tap {
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    
    ComMovieView *view = (ComMovieView *)tap.view;
    detail.Id = view.model.Id;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotMovieModel *model = _movieArr[indexPath.row];
    
    DetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailVC class])];
    detail.Id = model.Id;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)actionOnBackBarBtnTaped {
    [self.navigationController popViewControllerAnimated:YES];
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
