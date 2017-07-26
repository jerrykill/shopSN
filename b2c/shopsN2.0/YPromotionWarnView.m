//
//  YPromotionWarnView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionWarnView.h"

@interface YPromotionWarnView()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *englishLb;

@end

@implementation YPromotionWarnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(11, 10, 40, 26)];
    [self addSubview:_titleLb];
    _titleLb.textColor = __DefaultColor;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = BFont(10);
    _titleLb.text = [NSString stringWithFormat:@"%@就\n是优惠",ShortTitle];
    _titleLb.adjustsFontSizeToFitWidth=YES;
    _titleLb.numberOfLines = 2;

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(7, CGRectYH(_titleLb)+5, 47, 23)];
    [self addSubview:_detailLb];
    _detailLb.textColor = LH_RGBCOLOR(240, 197, 198);
    _detailLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.numberOfLines =3;
    _detailLb.font = MFont(6);
    _detailLb.text =[NSString stringWithFormat:@"采购办公产品\n上%@商城\n就够了",ShortTitle];
    _titleLb.adjustsFontSizeToFitWidth=YES;

    _englishLb = [[UILabel alloc]initWithFrame:CGRectMake(11, CGRectYH(_detailLb)+12, 37, 12)];
    [self addSubview:_englishLb];
    _englishLb.textColor = LH_RGBCOLOR(200, 200, 200);
    _englishLb.textAlignment = NSTextAlignmentLeft;
    _englishLb.font = MFont(5);
    _englishLb.numberOfLines = 2;
    _englishLb.text = [NSString stringWithFormat:@"%@ IS\n THE OFFER",mainNamepy];

}

@end
