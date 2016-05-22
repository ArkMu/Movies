//
//  SearchMovieCell.m
//  Movies
//
//  Created by qingyun on 16/4/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SearchMovieCell.h"

#import "SearchMovieModel.h"

#import "UIImageView+WebCache.h"

@interface SearchMovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UILabel *scLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *enmLabel;
@property (weak, nonatomic) IBOutlet UILabel *catLabel;

@end

@implementation SearchMovieCell

- (void)setModel:(SearchMovieModel *)model {
    _model = model;
    
//    http://p0.meituan.net/w.h/movie/__40191813__4767047.jpg
    
    NSString *str1 = [model.img substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.img substringWithRange:NSMakeRange(26, model.img.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    
    _nmLabel.text = model.nm;
    if (model.sc == 0) {
        _scLabel.text = @"暂无评分";
    } else {
        _scLabel.text = [NSString stringWithFormat:@"%.1f分", model.sc];
    }
    
    _pubDescLabel.text = model.pubDesc;
    _enmLabel.text = model.enm;
    _catLabel.text = model.cat;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
