//
//  HcmtCell.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HcmtCell.h"

#import "UIImageView+WebCache.h"

#import "HcmtModel.h"

@interface HcmtCell ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@property (weak, nonatomic) IBOutlet UIButton *replyBtn; //评论
@property (weak, nonatomic) IBOutlet UIButton *approveBtn;  //赞

@end

@implementation HcmtCell

- (void)setModel:(HcmtModel *)model {
    _model = model;
    
    _scoreLabel.text = [NSString stringWithFormat:@"%ld",model.score];
    _timeLabel.text = [model.time substringWithRange:NSMakeRange(5, 5)];
    _contentLabel.text = model.content;
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:model.avatarurl] placeholderImage:nil];
    _avatarImg.backgroundColor = [UIColor redColor];
    _avatarImg.layer.cornerRadius = 20;
    _avatarImg.layer.masksToBounds = YES;
    _nickLabel.text = model.nick;
    
    [_replyBtn setTitle:[NSString stringWithFormat:@"%ld", model.reply] forState:UIControlStateNormal];
    [_replyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [_approveBtn setTitle:[NSString stringWithFormat:@"%ld", model.approve] forState:UIControlStateNormal];
    [_approveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
