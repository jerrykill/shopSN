//
//  YQueryQuestionCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YQueryQuestionCell.h"

@interface YQueryQuestionCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UIView *bottomV;

@end

@implementation YQueryQuestionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor= [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailLb];
    [self addSubview:self.bottomV];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kWidth-20, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(15);
        _titleLb.textColor = __DTextColor;
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+12, __kWidth-20, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(107, 107, 107);
        _detailLb.font = MFont(13);
        _detailLb.numberOfLines = 0;
    }
    return _detailLb;
}

- (UIView *)bottomV  {
    if (!_bottomV) {
        _bottomV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 75, __kWidth, 10)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;

}

-(void)setDetail:(NSString *)detail{
    _detail = detail;
    CGSize size =[_detail boundingRectWithSize:CGSizeMake(__kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
    _detailLb.frame =CGRectMake(10, CGRectYH(_titleLb)+12, __kWidth-20, size.height);
    _detailLb.text = _detail;
    _bottomV.frame = CGRectMake(0, 75+size.height, __kWidth, 10);
}

@end
