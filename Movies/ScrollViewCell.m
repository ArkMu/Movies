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
