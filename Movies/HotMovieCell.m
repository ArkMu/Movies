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
    
//    http://p1.meituan.net/w.h/movie/4f06d5b4989902305bae7992ba2297e9162007.jpg
    
    NSString *str1 = [model.img substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.img substringWithRange:NSMakeRange(26, model.img.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
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
