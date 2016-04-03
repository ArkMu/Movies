//
//  HotMovieCell.m
//  Movies
//
//  Created by qingyun on 16/4/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotMovieCell.h"

#import "FMDatabase.h"

#import "HotMovieModel.h"

#import "UIImageView+WebCache.h"

#import "FMDBShare.h"

@interface HotMovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UILabel *mkLabel;
@property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *scmLabel;


@end

@implementation HotMovieCell

- (void)setModel:(HotMovieModel *)model {
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    _nmLabel.text = model.nm;
    _scmLabel.text = model.scm;
    _mkLabel.text = [NSString stringWithFormat:@"%.1f", model.mk];
    _showInfoLabel.text = model.showInfo;
    
    FMDBShare *share = [FMDBShare shareDataBase];
    if (![[share selectFromTableWithId:model.Id] count]) {  // 如果没有找到 则将该model插入到数据库
       [share insertInfoIntoTable:model];
    }
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
