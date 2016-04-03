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
    
    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
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
