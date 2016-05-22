//
//  FeedsOneCell.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FeedsOneCell.h"

#import "ImageModel.h"
#import "FeedsModel.h"

#import "UIImageView+WebCache.h"

@interface FeedsOneCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FeedsOneCell

- (void)setModel:(FeedsModel *)model {
    _model = model;
    
    ImageModel *Imodel = model.imageArr[0];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:Imodel.url] placeholderImage:nil];
    
    _titleLabel.text = model.title;
    _descriptionLabel.text = model.desc;
    _timeLabel.text = model.title;  // 时间处理
}

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
