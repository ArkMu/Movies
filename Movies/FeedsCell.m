//
//  CommentCell.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FeedsCell.h"

#import "FeedsModel.h"
#import "ImageModel.h"

#import "UIImageView+WebCache.h"

@interface FeedsCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *upCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation FeedsCell

- (void)setModel:(FeedsModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    ImageModel *leftImgModel = model.imageArr[0];
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:leftImgModel.url] placeholderImage:nil];
    
    ImageModel *centerImgModel = model.imageArr[1];
    [_centerImgView sd_setImageWithURL:[NSURL URLWithString:centerImgModel.url] placeholderImage:nil];
    
    ImageModel *rightImgModel = model.imageArr[2];
    [_rightImgView sd_setImageWithURL:[NSURL URLWithString:rightImgModel.url] placeholderImage:nil];

    _timeLabel.text = [NSString stringWithFormat:@"%ld", model.time];
    
    [_upCountBtn setTitle:[NSString stringWithFormat:@"%ld", model.upCount] forState:UIControlStateNormal];
    [_commentBtn setTitle:[NSString stringWithFormat:@"%ld", model.commentCount] forState:UIControlStateNormal];
}



- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
