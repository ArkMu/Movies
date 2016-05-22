//
//  ComMovieView.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ComMovieView.h"

#import "ComingModel.h"

#import "UIImageView+WebCache.h"

@interface ComMovieView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;


@end

@implementation ComMovieView

- (void)setModel:(ComingModel *)model {
    _model = model;
    
    
//http://p1.meituan.net/w.h/movie/4f06d5b4989902305bae7992ba2297e9162007.jpg
    NSString *str1 = [model.img substringWithRange:NSMakeRange(0, 22)];
    NSString *str2 = [model.img substringWithRange:NSMakeRange(26, model.img.length - 26)];
    
    NSString *urlStr = [str1 stringByAppendingString:str2];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    
    _nmLabel.text = model.nm;
    _wishLabel.text = [NSString stringWithFormat:@"%ld人想看",model.wish];
}



@end
