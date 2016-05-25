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
#import "MJRefresh.h"

#import "MovieModel.h"
#import "ActorModel.h"

#import "DetailHeaderView.h"

#import "ActorInfoBtnV.h"

#import "HcmtModel.h"
#import "HcmtCell.h"

#import "FilmReviewsModel.h"
#import "FilmReviewsCell.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>

@interface DetailVC () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MovieModel *MModel;

@property (nonatomic, strong) NSMutableArray *AMArr; // actor array

@property (nonatomic, strong) NSMutableArray *HcmtArr; //  短评

@property (nonatomic, strong) NSMutableArray *filmArr; // 长评论

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger netAccess;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DetailVC

static NSString *headerIdentifier = @"header";
static NSString *cellIdentifier = @"cell";

static NSString *hcmtIdentifier = @"hcmt";
static NSString *filmIdentifier = @"film";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _movieName;
    
    _manager = [AFHTTPSessionManager manager];
    
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBackBarButton)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    _tableView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    
    _tableView.rowHeight = 120;
    
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailHeaderView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HcmtCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:hcmtIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FilmReviewsCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:filmIdentifier];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _netAccess = 0;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadActorInfo];
            [self loadFilmData];
            [self loadHcmtData];
            [self loadMovieInfoData];
        });
        
        
    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
    
    [_tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    _netAccess = 0;
}

- (void)reloadTableView {
    if (_netAccess == 4) {
        [_tableView reloadData];
        [_timer invalidate];
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    }
}

- (void)loadMovieInfoData {
    
    // get movie info
    
    NSString *movieInfoUrl = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/\%ld.json?token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    
    [_manager GET:movieInfoUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        _MModel = [MovieModel modelWithDictionary:dict[@"data"][@"movie"]];
        
        DetailHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DetailHeaderView class]) owner:nil options:nil][0];
        headerView.model = _MModel;
        headerView.share = ^(MovieModel *model) {
            NSString *str1 = [model.img substringWithRange:NSMakeRange(0, 22)];
            NSString *str2 = [model.img substringWithRange:NSMakeRange(26, model.img.length - 26)];
            
            NSString *urlStr = [str1 stringByAppendingString:str2];
            
            NSArray *imageArr = @[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]]];
            
            if (imageArr) {
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                
                [shareParams SSDKSetupShareParamsByText:model.scm
                                                 images:imageArr
                                                    url:[NSURL URLWithString:@""]
                                                  title:model.nm
                                                   type:SSDKContentTypeAuto];
                
                [ShareSDK showShareActionSheet:nil
                                         items:nil
                                   shareParams:shareParams
                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                               
                               switch (state) {
                                   case SSDKResponseStateSuccess:
                                   {
                                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享成功"
                                                                                                      message:nil
                                                                                               preferredStyle:UIAlertControllerStyleAlert];
                                       
                                       UIAlertAction *action = [UIAlertAction actionWithTitle:@""
                                                                                        style:UIAlertActionStyleDefault
                                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                                          
                                                                                      }];
                                       [alert addAction:action];
                                       [self presentViewController:alert animated:YES completion:nil];
                                       
                                       [self resignFirstResponder];
                                       break;
                                   }
                                       
                                       
                                   case SSDKResponseStateFail:
                                   {
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                       message:[NSString stringWithFormat:@"%@",error]
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil, nil];
                                       [alert show];
                                       break;
                                   }
                                   default:
                                       break;
                               }
                           }];
            }
            
        };

        
        _tableView.tableHeaderView = headerView;
        
        
        _netAccess++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

}

- (void)loadActorInfo {
    // get actor info
    
    NSString *actorUrl = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v7/movie/\%ld/celebrities.json?utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    [_manager GET:actorUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *resultArr = dict[@"data"];
        
        _AMArr = [NSMutableArray array];
        for (NSArray *arr in resultArr) {
            NSMutableArray *marr = [NSMutableArray array];
            for (NSDictionary *dict in arr) {
                ActorModel *model = [ActorModel modelWithDictionary:dict];
                [marr addObject:model];
            }
            [_AMArr addObject:marr];
        }
        
        _netAccess++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)loadHcmtData {
    // 获取短评论
    
    NSString *hcmtUrl = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/comments/movie/v2/\%ld.json?token=&offset=0&limit=15&tag=0&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    [_manager GET:hcmtUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *arr = dict[@"cmts"];
        
        _HcmtArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            HcmtModel *model = [HcmtModel modelWithDictionary:dict];
            [_HcmtArr addObject:model];
        }
        
        _netAccess++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)loadFilmData {
    // 获取长评论
    NSString *filmUrl = [NSString stringWithFormat:@"http://api.maoyan.com/sns/movie/\%ld/filmReview/top.json?token=&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD", _Id];
    
    [_manager GET:filmUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *arr =  dict[@"data"][@"filmReviews"];
        
        _filmArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            FilmReviewsModel *model = [FilmReviewsModel modelWithDictionary:dict];
            [_filmArr addObject:model];
        }
        
        _netAccess++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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
        scrollView.showsHorizontalScrollIndicator = NO;
        
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                [view removeFromSuperview];
            }
        }
        
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

        scrollView.contentSize = CGSizeMake(80 * count, 100.0);
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
   
        FilmReviewsCell *cell = [tableView dequeueReusableCellWithIdentifier:filmIdentifier];
        cell.model = _filmArr[indexPath.row];
        return cell;
    
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


- (void)actionBackBarButton {
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
