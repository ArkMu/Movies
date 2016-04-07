//
//  ActorInfoBtnV.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ActorInfoBtnV.h"

#import "UIImageView+WebCache.h"

#import "ActorModel.h"

@interface ActorInfoBtnV ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *cnmLabel;
@property (weak, nonatomic) IBOutlet UILabel *rolesLabel;


@end

@implementation ActorInfoBtnV

- (void)setModel:(ActorModel *)model {
    _model = model;
    
//    http://p0.meituan.net/w.h/movie/6fa0e6b60153583959ab9ecf97e6cf2e34079.jpg
    
    NSString *str1 = [model.avatar substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.avatar substringWithRange:NSMakeRange(26, model.avatar.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    _cnmLabel.text = model.cnm;
    _rolesLabel.text = [NSString stringWithFormat:@"饰:%@", model.roles];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
