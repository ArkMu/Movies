//
//  DetailHeaderView.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailHeaderView.h"

#import "MovieModel.h"

#import "UIImageView+WebCache.h"

//#import "FMDatabase.h"

@interface DetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UILabel *enmLabel;
@property (weak, nonatomic) IBOutlet UILabel *scLabel;
@property (weak, nonatomic) IBOutlet UILabel *snumLabel;
@property (weak, nonatomic) IBOutlet UILabel *catLabel;
@property (weak, nonatomic) IBOutlet UILabel *srcAndDurLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *draLabel;

@end

@implementation DetailHeaderView

- (void)setModel:(MovieModel *)model {
    _model = model;
    
//    http://p1.meituan.net/w.h/movie/c53f0fdc271235ad365c749c461119fc80728.jpg
    
    NSString *str1 = [model.img substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.img substringWithRange:NSMakeRange(26, model.img.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    _nmLabel.text = model.nm;
    _enmLabel.text = model.enm;
    _scLabel.text = [NSString stringWithFormat:@"%.1f", model.sc];
    _snumLabel.text = [NSString stringWithFormat:@"(%ld人评分)", model.snum];
    _catLabel.text = model.cat;
    _srcAndDurLabel.text = [NSString stringWithFormat:@"%@ / %ld分钟", model.src, model.dur];
    _pubDescLabel.text = model.pubDesc;
    _draLabel.text = model.dra;
    
    
}


//- (BOOL)insertIntoTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
