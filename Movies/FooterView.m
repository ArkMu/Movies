//
//  FooterView.m
//  Movies
//
//  Created by qingyun on 16/4/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FooterView.h"

#import "FooterModel.h"
#import "ImageModel.h"

#import "UIButton+WebCache.h"

@interface FooterView ()

@property (nonatomic, strong) FooterModel *model;

@property (weak, nonatomic) IBOutlet UIButton *btnL;
@property (weak, nonatomic) IBOutlet UIButton *btnCL;
@property (weak, nonatomic) IBOutlet UIButton *btnCR;
@property (weak, nonatomic) IBOutlet UIButton *btnR;

@end

@implementation FooterView

- (void)awakeFromNib {
    
    
}

- (void)setModelArr:(NSArray<FooterModel *> *)modelArr {
    _modelArr = modelArr;
    
    FooterModel *modelL = _modelArr[0];
    [_btnL setTitle:modelL.title forState:UIControlStateNormal];
    [_btnL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnL.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    ImageModel *ImodelL = modelL.image;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImodelL.url]];
    UIImage *image = [UIImage imageWithData:data];
    [_btnL setImage:image forState:UIControlStateNormal];
    _btnL.imageView.contentMode = UIViewContentModeScaleAspectFit;
    

    _btnL.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
    _btnL.titleEdgeInsets = UIEdgeInsetsMake(0, -130, -50, -50);
    
    
    FooterModel *modelCL = _modelArr[1];
    [_btnCL setTitle:modelCL.title forState:UIControlStateNormal];
    [_btnCL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnCL.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    ImageModel *ImodelCL = modelCL.image;
    [_btnCL sd_setImageWithURL:[NSURL URLWithString:ImodelCL.url] forState:UIControlStateNormal];
    _btnCL.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _btnCL.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
    _btnCL.titleEdgeInsets = UIEdgeInsetsMake(0, -130, -50, -50);
    
    
    FooterModel *modelCR = _modelArr[2];
    [_btnCR setTitle:modelCR.title forState:UIControlStateNormal];
    [_btnCR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnCR.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    ImageModel *ImodelCR = modelCR.image;
    [_btnCR sd_setImageWithURL:[NSURL URLWithString:ImodelCR.url] forState:UIControlStateNormal];
    
    _btnCR.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
    _btnCR.titleEdgeInsets = UIEdgeInsetsMake(0, -130, -50, -50);
    
    FooterModel *modelR = _modelArr[3];
    [_btnR setTitle:modelR.title forState:UIControlStateNormal];
    [_btnR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnR.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    ImageModel *ImodelR = modelR.image;
    [_btnR sd_setImageWithURL:[NSURL URLWithString:ImodelR.url] forState:UIControlStateNormal];
    
    _btnR.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
    _btnR.titleEdgeInsets = UIEdgeInsetsMake(0, -130, -50, -50);
}

- (IBAction)ActionOnBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            _model = _modelArr[0];
            if (_gotoWebView) {
                _gotoWebView(_model.url);
            }
            break;
        }
        case 101:
        {
            _model = _modelArr[1];
            if (_gotoWebView) {
                _gotoWebView(_model.url);
            }
            break;
        }
        case 102:
        {
            _model = _modelArr[2];
            if (_gotoWebView) {
                _gotoWebView(_model.url);
            }
            break;
        }
        case 103:
        {
            _model = _modelArr[3];
            if (_gotoWebView) {
                _gotoWebView(_model.url);
            }
            break;
        }
            
        default:
            break;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
