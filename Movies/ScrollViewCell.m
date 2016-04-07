//
//  ScrollViewCell.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ScrollViewCell.h"

#import "UIImageView+WebCache.h"
#import "Common.h"
#import "Masonry/Masonry.h"

#import "ScrollViewModel.h"

@interface ScrollViewCell () 

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;

@property (nonatomic, assign) NSInteger currentIndex;

//@property (nonatomic, strong) UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *cotainerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *commontTitleLabel;

@end

@implementation ScrollViewCell

- (void)awakeFromNib {
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _centerImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionOnTap)];
    [_centerImgView addGestureRecognizer:tap];
    
    _cotainerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    
}

- (void)actionOnTap {
    ScrollViewModel *model = _modelArr[_currentIndex];
    
//    NSString *regExString = @"meituanmovie"
//    meituanmovie://www.meituan.com/forum/postDetail?postID=94593
    
//    http://api.meituan.com/sns/topic/94593.json?__vhost=api.maoyan.com&utm_campaign=AmovieBmovieCD-1&movieBundleVersion=6601&utm_source=qihu360-dy&utm_medium=android&utm_term=6.6.0&utm_content=353617055672400&ci=73&net=255&dModel=LT26ii&uuid=587CEF31FE587F2FDEB7EA51D16D4D7C3165B08724FB309D1056B5BED71757FD&lat=34.819315&lng=113.564283&__skck=6a375bce8c66a0dc293860dfa83833ef&__skts=1459864028118&__skua=7e01cf8dd30a179800a7a93979b430b2&__skno=a740f5e9-4b89-4a12-93b7-2e2ec17a4a90&__skcy=gUDAhqRDbikC%2BM7EGURABV13ONA%3D
    
    if (_gotoWebView) {
        _gotoWebView(model.url);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
}

- (void)setModelArr:(NSArray<ScrollViewModel *> *)modelArr {
    _modelArr = modelArr;
    
    _pageControl.currentPage = _currentIndex;
    _pageControl.numberOfPages = _modelArr.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.1 alpha:0.4];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_cotainerView);
    }];
    
    [self setImgViewForScrollView];
}

- (void)setImgViewForScrollView {
    _pageControl.currentPage = _currentIndex;
    
    NSInteger leftIndex = [self indexEnable:_currentIndex - 1];
    ScrollViewModel *leftModel = _modelArr[leftIndex];
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:leftModel.imgUrl] placeholderImage:nil];
    
    NSInteger centerIndex = [self indexEnable:_currentIndex];
    ScrollViewModel *centerModel = _modelArr[centerIndex];
    [_centerImgView sd_setImageWithURL:[NSURL URLWithString:centerModel.imgUrl] placeholderImage:nil];
    _centerImgView.userInteractionEnabled = YES;
    _commontTitleLabel.text = centerModel.commonTitle;
    _commontTitleLabel.textColor = [UIColor whiteColor];
    _commontTitleLabel.font = [UIFont systemFontOfSize:13.0];
     
     NSInteger rightIndex = [self indexEnable:_currentIndex + 1];
    ScrollViewModel *rightModel = _modelArr[rightIndex];
    [_rightImgView sd_setImageWithURL:[NSURL URLWithString:rightModel.imgUrl] placeholderImage:nil];
    
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
    
}

- (NSInteger)indexEnable:(NSInteger)index {
    if (index < 0) {
        return _modelArr.count - 1;
    } else if (index > _modelArr.count - 1) {
        return 0;
    }
    
    return index;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        _currentIndex--;
    } else if (scrollView.contentOffset.x == 2 * ScreenW) {
        _currentIndex++;
    }
    
    _currentIndex = [self indexEnable:_currentIndex];
    [self setImgViewForScrollView];
}

@end
