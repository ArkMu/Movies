//
//  MoviePlayerVC.m
//  Movies
//
//  Created by qingyun on 16/4/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

//http://v.meituan.net/movie/videos/7783a77abb5b42feb3b9fa273942f8e5.mp4

#import "MoviePlayerVC.h"

#import "Common.h"

#import <AVFoundation/AVFoundation.h>

#import "AFHTTPSessionManager.h"

#import "MoviePlayModel.h"
#import "MoviePlayCell.h"

#import "MoviePlayHeaderModel.h"
#import "MoviePlayHeaderView.h"

@interface MoviePlayerVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *movieArr;

@property (nonatomic, strong) MoviePlayHeaderModel *headerModel;

@end

@implementation MoviePlayerVC

static NSString *cellIdentifier = @"cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBar.translucent = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadPlayerView:_videoUrl];
    });
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBackBarButton)];
}

- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    NSDictionary *parameter = @{@"Host":@"api.meituan.com",
//                                @"Connection":@"Keep-Alive",
//                                @"Accept-Encoding":@"gzip",
//                                @"__skcy":@"xMpejxE0Y8YJFgZ6PtszuSVbHGU=",
//                                @"__skua":@"7e01cf8dd30a179800a7a93979b430b2",
//                                @"__skno":@"fc9c9f2f-8714-4c6d-9524-21c722e640e0",
//                                @"__skck":@"6a375bce8c66a0dc293860dfa83833ef",
//                                @"__skts":@"1459905918645",
//                                @"User-Agent":@"AiMovie /SEMC-4.1.2-LT26ii_1266-9060-1280x720-320-6.6.0-6601-353617055672400-qihu360-dy"
//                                };
    
    [manager GET:@"http://api.meituan.com/mmdb/movie/246234/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819342&lng=113.564188&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459905918645&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=fc9c9f2f-8714-4c6d-9524-21c722e640e0&__skcy=xMpejxE0Y8YJFgZ6PtszuSVbHGU%3D" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSArray *arr = resultDict[@"vlist"];
        
        NSDictionary *headerDict = resultDict[@"movieVO"];
        _headerModel = [MoviePlayHeaderModel modelWithDictionary:headerDict];
        
        _movieArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            MoviePlayModel *model = [MoviePlayModel modelWithDictionary:dict];
            [_movieArr addObject:model];
        }
        
        [self loadTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    MoviePlayHeaderView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MoviePlayHeaderView class]) owner:nil options:nil][0];
    view.frame = CGRectMake(0, 200, self.view.frame.size.width, 80);
    view.model = _headerModel;
    _tableView.tableHeaderView = view;
    
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviePlayCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _movieArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviePlayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = _movieArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviePlayModel *model = _movieArr[indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [self loadPlayerView:model.url]; 
    });
    
}

- (void)loadPlayerView:(NSString *)videoUrl {
    
    // remove layer 需要先 copy
    [[self.view.layer.sublayers copy] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *subLayer = obj;
        if ([subLayer isKindOfClass:[AVPlayerLayer class]]) {
            [subLayer removeFromSuperlayer];
        }
    }];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoUrl]];
    
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0, ScreenW, 200);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    
    [self.view.layer addSublayer:playerLayer];
    
    [_player play];
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
