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
#import "Masonry/Masonry.h"

#import "MoviePlayModel.h"
#import "MoviePlayCell.h"

#import "MoviePlayHeaderModel.h"
#import "MoviePlayHeaderView.h"

@interface MoviePlayerVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *movieArr;

@property (nonatomic, strong) MoviePlayHeaderModel *headerModel;

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *lLabel;
@property (nonatomic, strong) UILabel *rLabel;

@property (nonatomic, assign) CGFloat totalVideoTime;

@property (nonatomic, strong) id observer;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self loadPlayerView:_videoUrl];
    
    self.title = _movieName;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBackBarButton)];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    _player = nil;
    
}

- (void)loadData {
    
    _manager = [AFHTTPSessionManager manager];
    
      NSString *url =  @"http://api.meituan.com/mmdb/movie/246375/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6801&utm_source=qihu360-dy&utm_medium=android&utm_term=6.8.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.81933&lng=113.564789&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1463839165989&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=42939e16-7f3d-44be-96ed-ece4f260937b&__skcy=f%2F8rKlvMFPtV1CAh6SCXKYPcF6A%3D";
    
//    http://api.meituan.com/mmdb/movie/13511/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6801&utm_source=qihu360-dy&utm_medium=android&utm_term=6.8.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819324&lng=113.564869&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1463837636124&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=db50ecf7-cc2d-4b65-a5e3-5bc26543320b&__skcy=uNPTBTVeQ4vewtqm5sedHhBg4fI%3D
    
//    http://api.meituan.com/mmdb/movie/246333/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6801&utm_source=qihu360-dy&utm_medium=android&utm_term=6.8.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819272&lng=113.564635&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1463744659519&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=e7f40d62-b86d-4e12-a5f9-05b6f9b797b5&__skcy=%2BM0EEx04Z55vmY40AXkDqcvAi1s%3D
    
    // 独立战争
//    http://api.meituan.com/mmdb/movie/246375/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6801&utm_source=qihu360-dy&utm_medium=android&utm_term=6.8.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.81933&lng=113.564789&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1463839165989&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=42939e16-7f3d-44be-96ed-ece4f260937b&__skcy=f%2F8rKlvMFPtV1CAh6SCXKYPcF6A%3D
    
    // 爱丽丝
//    http://api.meituan.com/mmdb/movie/343379/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6801&utm_source=qihu360-dy&utm_medium=android&utm_term=6.8.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.81933&lng=113.564789&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1463839409974&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=8a55dd50-7364-4e68-bf46-41f7c6cd60f2&__skcy=RqlTFXgAR3acboP7uQJQksepP8o%3D
    
//    NSString *baseUrl = [NSString stringWithFormat:@"http://api.meituan.com/mmdb/movie/%ld/videos.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6801&utm_source=qihu360-dy&utm_medium=android&utm_term=6.8.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.81933&lng=113.564789&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1463839165989&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=42939e16-7f3d-44be-96ed-ece4f260937b&__skcy=f/8rKlvMFPtV1CAh6SCXKYPcF6A=", _movieId];
    
    [_manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        NSLog(@"----%@", error);
        
    }];
    
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height - 220) style:UITableViewStylePlain];
    
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
    [self.player pause];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.player removeTimeObserver:_observer];
   
    [self loadPlayerView:model.url];
    
}

-(AVPlayer *)player {
    if (_player == nil) {
        _player = [[AVPlayer alloc]init];
        
    }
    return _player;
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
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0, ScreenW, 200);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
        [self.view addSubview:_playBtn];
        [_playBtn addTarget:self action:@selector(pauseMovie) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_lLabel == nil) {
        _lLabel = [[UILabel alloc] init];
        _lLabel.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:_lLabel];
        
        [_lLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(_playBtn.mas_bottom);
        }];
    }
    if (_rLabel == nil) {
        _rLabel = [[UILabel alloc] init];
        _rLabel.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:_rLabel];
        
        [_rLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lLabel);
            make.trailing.mas_equalTo(0);
            make.size.mas_equalTo(_lLabel);
        }];
        
    }
    
    if (_slider == nil) {
        _slider = [[UISlider alloc] init];
        [self.view addSubview:_slider];
        
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_lLabel.mas_trailing);
            make.top.mas_equalTo(_lLabel);
            make.trailing.mas_equalTo(_rLabel.mas_leading);
        }];
        
        [_slider setThumbImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        
        _slider.maximumTrackTintColor = [UIColor whiteColor];
        _slider.minimumTrackTintColor = [UIColor redColor];
        _slider.continuous = NO;
        
        _slider.userInteractionEnabled = NO;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    [self addProgressObserver];
    
    [self.view.layer addSublayer:playerLayer];
    
    [_player play];
    [playerLayer setNeedsDisplay];

}

- (void)sliderValueChanged:(UISlider *)slide {
    [self.player pause];
    
    float current = (float)(self.totalVideoTime * slide.value);
    CMTime currentTime = CMTimeMake(current, 1);
    [self.player seekToTime:currentTime completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}

- (void)addProgressObserver {
    AVPlayerItem *playItem = self.player.currentItem;
    
    __weak typeof(self) mySelf = self;
    
    _observer = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        mySelf.slider.userInteractionEnabled = YES;
        
        float current = CMTimeGetSeconds(time);
        
        float total = CMTimeGetSeconds([playItem duration]);
        
        CMTime totalTime = playItem.duration;
        
        mySelf.totalVideoTime = (CGFloat)totalTime.value/totalTime.timescale;
        
        [mySelf.slider setValue:(current / total) animated:YES];
        
        mySelf.lLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", (NSInteger)current / 60, (NSInteger)current % 60];
        mySelf.rLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", (NSInteger)total / 60, (NSInteger)total % 60];
        
    }];
    
}


- (void)updateSlider {
    _slider.value = [_player currentTime].value;
}

- (void)actionBackBarButton {
    _player = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pauseMovie {
    if (!_isPlaying) {
        [_player pause];
        UIImage *image = [UIImage imageNamed:@"pause"];
        [self.playBtn setImage:image forState:UIControlStateNormal];
        [self.view bringSubviewToFront:self.playBtn];
    } else {
        [_player play];
        [self.playBtn setImage:nil forState:UIControlStateNormal];
    }
    
    _isPlaying = !_isPlaying;
}

@end
