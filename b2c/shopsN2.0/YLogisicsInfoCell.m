//
//  YLogisicsInfoCell.m
//  shopsN
//
//  Created by imac on 2016/12/26.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YLogisicsInfoCell.h"

@interface YLogisicsInfoCell ()

@property (strong,nonatomic) UIImageView *backV;

@property (strong,nonatomic) UIImageView *topIV;

@property (strong,nonatomic) UIImageView *bottomIV;

@property (strong,nonatomic) UIImageView *startIV;

@property (strong,nonatomic) UIImageView *endIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *timeLb;

//@property (strong,nonatomic) UILabel *nameLb;

@end

@implementation YLogisicsInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.backV];

    [self addSubview:self.startIV];
    [self bringSubviewToFront:_startIV];

    [self addSubview:self.endIV];
    [self bringSubviewToFront:_endIV];

    [self addSubview:self.topIV];
    [self sendSubviewToBack:_topIV];

    [self addSubview:self.bottomIV];
    [self sendSubviewToBack:_bottomIV];

    [_backV addSubview:self.timeLb];

//    [_backV addSubview:self.nameLb];

    [_backV addSubview:self.titleLb];

}

#pragma mark ==懒加载==
-(UIImageView *)backV{
    if (!_backV) {
        _backV = [[UIImageView alloc]initWithFrame:CGRectMake(34, 20, __kWidth-45, 56)];
        UIImage *image = MImage(@"wuliu");
        CGFloat scale = [UIScreen mainScreen].scale;
        UIImage *dot = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20/scale, 15/scale, 10/scale, 15/scale) resizingMode:UIImageResizingModeStretch];
        _backV.image= dot;
    }
    return _backV;
}

-(UIImageView *)startIV{
    if (!_startIV) {
        _startIV = [[UIImageView alloc]initWithFrame:CGRectMake(13, 34, 10, 10)];
        _startIV.layer.cornerRadius = 5;
        _startIV.layer.borderWidth = 3;
        _startIV.layer.borderColor = LH_RGBCOLOR(181, 181, 181).CGColor;
        _startIV.backgroundColor = [UIColor whiteColor];
    }
    return _startIV;
}

-(UIImageView *)endIV{
    if (!_endIV) {
        _endIV = [[UIImageView alloc]initWithFrame:CGRectMake(9, 32, 18, 18)];
        _endIV.backgroundColor = LH_RGBCOLOR(224, 40, 40);
        _endIV.layer.cornerRadius = 9;
        _endIV.layer.borderWidth = 3;
        _endIV.layer.borderColor = HEXCOLOR(0xffc2c2).CGColor;
        _endIV.hidden = YES;
    }
    return _endIV;
}

-(UIImageView *)topIV{
    if (!_topIV) {
        _topIV = [[UIImageView alloc]initWithFrame:CGRectMake(18, 0, 1, 35)];
        _topIV.backgroundColor = LH_RGBCOLOR(187, 187, 187);
    }
    return _topIV;
}

-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(18, CGRectYH(_topIV), 1, 41)];
        _bottomIV.backgroundColor = LH_RGBCOLOR(187, 187, 187);
    }
    return _bottomIV;
}

-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(14, 4, 125, 15)];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _timeLb.font = MFont(11);
    }
    return _timeLb;
}

//-(UILabel *)nameLb{
//    if (!_nameLb) {
//        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-45-80, 4, 65, 15)];
//        _nameLb.textAlignment = NSTextAlignmentRight;;
//        _nameLb.textColor = LH_RGBCOLOR(153, 153, 153);
//        _nameLb.font = MFont(13);
//    }
//    return _nameLb;
//}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(14, 30, __kWidth-45-38, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

-(void)setData:(YLogisicsInfoModel *)data {
    _data = data;
    NSString *text = _data.info;
    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-45-38, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(15)} context:nil].size;
    _titleLb.text = text;
    _backV.frame = CGRectMake(34, 20, __kWidth-45, 41+size.height);
    _titleLb.frame = CGRectMake(14, 30, __kWidth-45-38, size.height);
    _bottomIV.frame = CGRectMake(18, 35, 1, size.height+26);

    _timeLb.text = _data.time;

}

//-(void)setTitle:(NSString *)title{
//    NSString *text = title;
//    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-45-38, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(15)} context:nil].size;
//    _titleLb.text = text;
//    _backV.frame = CGRectMake(34, 20, __kWidth-45, 41+size.height);
//    _titleLb.frame = CGRectMake(14, 30, __kWidth-45-38, size.height);
//    _bottomIV.frame = CGRectMake(18, 35, 1, size.height+26);
//
//    
//}

//-(void)setName:(NSString *)name{
//    _nameLb.text = name;
//}

//-(void)setTime:(NSString *)time{
//    _timeLb.text = time;
//}

-(void)setType:(NSInteger)type{
    if (type==0) {
        _bottomIV.hidden = YES;
        _topIV.hidden = NO;
        _endIV.hidden = YES;
        _startIV.hidden = NO;
        _titleLb.textColor = __DTextColor;
    }else if (type==1){
        _topIV.hidden = YES;
        _bottomIV.hidden = NO;
        _endIV.hidden = NO;
        _startIV.hidden = YES;
        _titleLb.textColor = LH_RGBCOLOR(224, 40, 40);
    }else{
        _topIV.hidden = NO;
        _bottomIV.hidden = NO;
        _startIV.hidden = NO;
        _endIV.hidden = YES;
        _titleLb.textColor = __DTextColor;
    }
}

@end
