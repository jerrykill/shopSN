//
//  YOrderdetailHeadCell.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderdetailHeadCell.h"

@interface YOrderdetailHeadCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *statusBtn;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YOrderdetailHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.statusBtn];
    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, __kWidth-90, 16)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(16);
    }
    return _titleLb;
}

-(UIButton *)statusBtn{
    if (!_statusBtn) {
        _statusBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-70, 12, 60, 20)];
        _statusBtn.titleLabel.font = MFont(16);
        [_statusBtn setTitleColor:__DefaultColor forState:BtnNormal];
        _statusBtn.userInteractionEnabled = NO;
    }
    return _statusBtn;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 46, __kWidth, 3)];
        _lineIV.image = MImage(@"address_line");
    }
    return _lineIV;
}

-(void)setOrderNo:(NSString *)orderNo{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单编号：%@",orderNo]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(0, 5)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(40, 40, 40) range:NSMakeRange(5, orderNo.length)];
    _titleLb.attributedText = attr;
}

-(void)setStatus:(NSString *)status{
    [_statusBtn setTitle:status forState:BtnNormal];
}

@end
