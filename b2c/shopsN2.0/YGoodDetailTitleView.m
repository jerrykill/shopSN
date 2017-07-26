//
//  YGoodDetailTitleView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailTitleView.h"
#import "YGoodDetailPromotionView.h"

@interface YGoodDetailTitleView()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *shareBtn;

@property (strong,nonatomic) UILabel *timeLb;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UILabel *oldPriceLb;

@property (strong,nonatomic) YGoodDetailPromotionView *promotionV;

@property (nonatomic) NSInteger Time;

@property (strong,nonatomic) NSTimer *timer;


@end

@implementation YGoodDetailTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LH_RGBCOLOR(241, 241, 241);
        _Time = 0;

    }
    return self;
}



-(void)setModel:(YGoodDetailModel *)model{
    _model= model;
    for (id obj in self.subviews) {
        [obj removeFromSuperview];
    }
    [self addSubview:self.titleLb];
    _titleLb.text = model.goodTitle;

    [self addSubview:self.shareBtn];

    if (_model.list.count) {//有活动
       [self addSubview:self.timeLb];
        if (!_Time) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduce) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
        NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
        NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
        _Time = [_model.time integerValue]-[timeSp integerValue];

        NSInteger d=_Time/(60*60*24);
        NSInteger h =_Time%(60*60*24)/(60*60);
        NSInteger m =_Time%(60*60*24)%(60*60)/60;
        NSInteger s =_Time%(60*60*24)%(60*60)%60;

        _timeLb.text = [NSString stringWithFormat:@"促销剩余时间:%ld天%ld小时%ld分钟%ld秒",d,h,m,s];

        [self addSubview:self.priceLb];
        _priceLb.frame = CGRectMake(10, CGRectYH(_timeLb)+17, 90, 20);
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodMoney]];
        [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 1)];
        [attr addAttribute:NSFontAttributeName value:MFont(19) range:NSMakeRange(1, attr.length-3)];
        [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(attr.length-3, 3)];
        _priceLb.attributedText = attr;

        [self addSubview:self.oldPriceLb];
        NSMutableAttributedString *attt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价：¥%@",_model.goodOldMoney]];
        [attt addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(4, attt.length-4)];
        _oldPriceLb.attributedText = attt;

        [self addSubview:self.promotionV];
        _promotionV.frame = CGRectMake(0, CGRectYH(_priceLb)+15, __kWidth, _model.list.count*30);
        _promotionV.data = _model.list;
    }else{//无活动
        [self addSubview:self.priceLb];
        _priceLb.frame = CGRectMake(10, CGRectYH(_titleLb)+17, 90, 20);

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodMoney]];
        [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 1)];
        [attr addAttribute:NSFontAttributeName value:MFont(19) range:NSMakeRange(1, attr.length-3)];
        [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(attr.length-3, 3)];
        _priceLb.attributedText = attr;
    }
}

#pragma mark ==分享==
-(void)shareAction{
    [self.delegate goodShare];
    
}

-(void)reduce{
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    if (_Time>0) {
         _Time = [_model.time integerValue]-[timeSp integerValue];
        NSInteger d=_Time/(60*60*24);
        NSInteger h =_Time%(60*60*24)/(60*60);
        NSInteger m =_Time%(60*60*24)%(60*60)/60;
        NSInteger s =_Time%(60*60*24)%(60*60)%60;
        _timeLb.text = [NSString stringWithFormat:@"促销剩余时间:%ld天%ld小时%ld分钟%ld秒",d,h,m,s];
    }
}

-(void)dealloc{
    [_timer invalidate];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, __kWidth-70, 44)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(18);
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+20, 12, 40, 44)];
        [_shareBtn setImage:MImage(@"share") forState:BtnNormal];
        [_shareBtn setTitle:@"分享" forState:BtnNormal];
        [_shareBtn setTitleColor:LH_RGBCOLOR(117, 117, 117) forState:BtnNormal];
        _shareBtn.titleLabel.font = MFont(12);
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 13, 20, 13);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(25, -16, 0, 0);
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:BtnTouchUpInside];
    }
    return _shareBtn;
}


-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+12, __kWidth-40, 15)];
        _timeLb.textColor = LH_RGBCOLOR(224, 40, 40);
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.font = MFont(13);
    }
    return _timeLb;
}

-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]init];
        _priceLb.textAlignment = NSTextAlignmentLeft;
        _priceLb.textColor = LH_RGBCOLOR(224, 40, 40);
    }
    return _priceLb;
}

-(UILabel *)oldPriceLb{
    if (!_oldPriceLb) {
        _oldPriceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_priceLb)+5, CGRectYH(_timeLb)+22, 110, 15)];
        _oldPriceLb.textAlignment = NSTextAlignmentLeft;
        _oldPriceLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _oldPriceLb.font = MFont(13);
    }
    return _oldPriceLb;
}

-(YGoodDetailPromotionView *)promotionV{
    if (!_promotionV) {
        _promotionV = [[YGoodDetailPromotionView alloc]init];
    }
    return _promotionV;
}

@end
