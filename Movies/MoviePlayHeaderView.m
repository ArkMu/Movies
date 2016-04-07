//
//  MoviePlayHeaderView.m
//  Movies
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MoviePlayHeaderView.h"

#import "UIImageView+WebCache.h"
#import "MoviePlayHeaderModel.h"

@interface MoviePlayHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubdescLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end



@implementation MoviePlayHeaderView

- (void)setModel:(MoviePlayHeaderModel *)model {
    _model = model;
    
//    http://p1.meituan.net/w.h/movie/cde09df392a65ce6b0f655c8ddc2cd95346780.jpg
    NSString *str1 = [model.image substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.image substringWithRange:NSMakeRange(26, model.image.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    
    _nameLabel.text = model.name;
    _pubdescLabel.text = model.pubdesc;
    _wishLabel.text  =[NSString stringWithFormat:@"%ld人想看", model.wish];
    
    _btn.layer.borderWidth = 1.0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){1,0,0,1});
    
    _btn.layer.borderColor = borderColorRef;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnAction:(UIButton *)sender {
}

@end
