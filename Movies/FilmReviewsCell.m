//
//  FilmReviewsCell.m
//  Movies
//
//  Created by qingyun on 16/4/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FilmReviewsCell.h"

#import "FilmReviewsModel.h"
#import "AuthorModel.h"

#import "UIImageView+WebCache.h"

@interface FilmReviewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *txLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipInfoLabel;

@property (weak, nonatomic) IBOutlet UIButton *upCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentCountBtn;

@end

@implementation FilmReviewsCell

- (void)setModel:(FilmReviewsModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _txLabel.text = model.text;
    NSString *urlStr = model.author.avatarurl;
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    _avatarImg.layer.cornerRadius = 20;
    _avatarImg.layer.masksToBounds = YES;
    _nickNameLabel.text = model.author.nickName;
    _vipInfoLabel.text = model.author.vipInfo;
    
    [_upCountBtn setTitle:[NSString stringWithFormat:@"%ld", model.upCount] forState:UIControlStateNormal];
    [_upCountBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [_commentCountBtn setTitle:[NSString stringWithFormat:@"%ld", model.commentCount] forState:UIControlStateNormal];
    [_commentCountBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
