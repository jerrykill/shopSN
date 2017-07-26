//
//  YGoodReturnsCell.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodReturnsCell.h"

@interface YGoodReturnsCell()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UIButton *actionBtn;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YGoodReturnsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.numLb];
    [self addSubview:self.actionBtn];
    [self addSubview:self.lineIV];

}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 72, 72)];
        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.layer.borderColor = __BackColor.CGColor;
        _goodIV.layer.borderWidth = 1;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 15, __kWidth-120, 36)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(14);
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

-(UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+10, 100, 15)];
        _numLb.textAlignment = NSTextAlignmentLeft;
        _numLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _numLb.font = MFont(14);
    }
    return _numLb;
}

-(UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-80, CGRectYH(_titleLb)+10, 70, 28)];
        _actionBtn.layer.borderWidth = 1;
        _actionBtn.layer.cornerRadius = 4;
        _actionBtn.layer.borderColor = __DTextColor.CGColor;
        _actionBtn.titleLabel.font = MFont(14);
        _actionBtn.userInteractionEnabled = YES;
        [_actionBtn addTarget:self action:@selector(choose) forControlEvents:BtnTouchUpInside];
    }
    return _actionBtn;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, __kWidth-20, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(void)setModel:(YReturnsGoodModel *)model{
    _model =model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.imageName]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.title;
    _numLb.text = [NSString stringWithFormat:@"数量：%@",_model.num];
    if ([_model.status isEqualToString:@"0"]) {
        _actionBtn.backgroundColor = [UIColor whiteColor];
        _actionBtn.layer.borderWidth = 1;
        [_actionBtn setTitle:@"申请售后" forState:BtnNormal];
        [_actionBtn setTitleColor:__DTextColor forState:BtnNormal];
    }else if ([_model.status isEqualToString:@"1"]){
        [_actionBtn setTitle:@"待审核" forState:BtnNormal];
        _actionBtn.backgroundColor = __DefaultColor;
        [_actionBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        _actionBtn.layer.borderWidth =0;
    }

}


- (void)choose{
    [self.delegate chooseAction:self.tag];
}

@end
