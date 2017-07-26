//
//  YGoodAppraiseCell.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodAppraiseCell.h"
#import "YGoodAppraiseHeadView.h"

@interface YGoodAppraiseCell ()

@property (strong,nonatomic) YGoodAppraiseHeadView *headV;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *goodLb;

@end

@implementation YGoodAppraiseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headV];
    [self addSubview:self.detailLb];
    [self addSubview:self.goodLb];


}

#pragma mark ==懒加载==
-(YGoodAppraiseHeadView *)headV{
    if (!_headV) {
        _headV = [[YGoodAppraiseHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 30)];
    }
    return _headV;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_headV)+3, __kWidth-25, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.numberOfLines = 0;
        _detailLb.font = MFont(12);
        _detailLb.textColor = __DTextColor;
    }
    return _detailLb;
}

-(UILabel *)goodLb{
    if (!_goodLb) {
        _goodLb = [[UILabel alloc]init];
        _goodLb.textAlignment = NSTextAlignmentLeft;
        _goodLb.font = MFont(10);
        _goodLb.textColor = LH_RGBCOLOR(153, 153, 153);
    }
    return _goodLb;
}

-(void)setModel:(YGoodAppraiseModel *)model{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    _model = model;
    _headV.model = _model;
    NSString *text = _model.info;
    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(12)} context:nil].size;
    _detailLb.text =text;
    _detailLb.frame = CGRectMake(10,  CGRectYH(_headV)+3, size.width, size.height);

    for (int i=0; i<_model.imageArr.count; i++) {
        if (i<3) {
            UIImageView *picIV = [[UIImageView alloc]initWithFrame:CGRectMake(10+60*i,CGRectYH(_detailLb)+ 10, 49, 49)];
            [self addSubview:picIV];
            [picIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.imageArr[i]]] placeholderImage: MImage(goodPlachorName)];
            picIV.backgroundColor = LH_RandomColor;
        }
    }
    NSInteger t =0;
    if (_model.imageArr.count) {
        t=1;
    }
    _goodLb.frame = CGRectMake(10, CGRectYH(_detailLb)+10+t*70, __kWidth-25, 15);
    NSString *str= @"";
    for (YGoodTypeModel*type in _model.list) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",type.name,type.size]];
    }
    _goodLb.text = str;

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectYH(_goodLb)+19, __kWidth, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;

}

@end
