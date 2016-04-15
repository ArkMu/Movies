//
//  MovieDetailCell.m
//  Movies
//
//  Created by qingyun on 16/4/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MovieDetailCell.h"

#import "NewsHeadLinesModel.h"
#import "HotMovieModel.h"

#import "UIImageView+WebCache.h"

@interface MovieDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *frtLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleULabel;
@property (weak, nonatomic) IBOutlet UILabel *titleBLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeULabel;
@property (weak, nonatomic) IBOutlet UILabel *typeBLabel;

@property (weak, nonatomic) IBOutlet UIButton *wishBtn;

@end

@implementation MovieDetailCell

- (void)setModel:(HotMovieModel *)model {
    _model = model;
//    http://p0.meituan.net/w.h/movie/e72a8be576d4125f7a306f27a292a78a156488.jpg
    
    NSString *str1 = [model.img substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.img substringWithRange:NSMakeRange(26, model.img.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    
    _nmLabel.text = model.nm;
    _wishLabel.text = [NSString stringWithFormat:@"%ld人想看", model.wish];
    _descLabel.text = model.desc;
    
    if (model.fra == nil || model.frt == nil) {
        _frtLabel.text = @"";
    } else {
        _frtLabel.text = [NSString stringWithFormat:@"%@%@上映", model.frt, model.fra];
    }
    
    
    if (model.newsHeadline.count == 0) {
        return;
    }
    if (model.newsHeadline.count == 1) {
        NewsHeadLinesModel *headLine = model.newsHeadline[0];
        _titleULabel.text = headLine.title;
        _typeULabel.text = headLine.type;
        return;
    }
    NewsHeadLinesModel *headLine = model.newsHeadline[0];
    _titleULabel.text = headLine.title;
    _typeULabel.text = headLine.type;
    
    
    NewsHeadLinesModel *headLin = model.newsHeadline[1];
    _titleBLabel.text = headLin.title;
    _typeBLabel.text = headLin.type;
}

- (void)awakeFromNib {
    [_wishBtn.layer setBorderColor:[UIColor redColor].CGColor];
    [_wishBtn.layer setBorderWidth:1.0];
    [_wishBtn.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)whishToLook:(UIButton *)sender {
}

- (IBAction)actionOnBtnTop:(UIButton *)sender {
//    meituanmovie://www.meituan.com/forum/postDetail?postID=94705
    NewsHeadLinesModel *model = _model.newsHeadline[0];
    if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]]) {
        NSLog(@"ok");
    };
    
}


- (IBAction)actionOnBtnBottom:(UIButton *)sender {
    NewsHeadLinesModel *model = _model.newsHeadline[1];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
}


@end
