//
//  ComMovieView.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ComMovieView.h"

#import "ComingModel.h"

#import "UIImageView+WebCache.h"

@interface ComMovieView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;


@end

@implementation ComMovieView

- (void)setModel:(ComingModel *)model {
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    _nmLabel.text = model.nm;
    _wishLabel.text = [NSString stringWithFormat:@"%ld人想看",model.wish];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
