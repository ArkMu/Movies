//
//  MoviePlayCell.m
//  Movies
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MoviePlayCell.h"

#import "UIImageView+WebCache.h"

#import "MoviePlayModel.h"

@interface MoviePlayCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *tlLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation MoviePlayCell

- (void)setModel:(MoviePlayModel *)model {
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
    _tlLabel.text = model.tl;
    _tmLabel.text = [NSString stringWithFormat:@"时长 : %2ld:%2ld", model.tm / 60, model.tm % 60];
    _countLabel.text = [NSString stringWithFormat:@"观看 : %ld", model.count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
