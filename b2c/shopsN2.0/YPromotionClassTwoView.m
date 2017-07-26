//
//  YPromotionClassTwoView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionClassTwoView.h"

@interface YPromotionClassTwoView ()

@property (strong,nonatomic) UIImageView *backIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *englishLb;

@property (strong,nonatomic) UIImageView *classIV;

@property (strong,nonatomic) UIButton*goinBtn;

@end

@implementation YPromotionClassTwoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = __kWidth/2;
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, width-15, 170)];
    [self addSubview:_backIV];
    _backIV.contentMode = UIViewContentModeScaleAspectFill;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, width-40, 22)];
    [_backIV addSubview:_titleLb];
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.textAlignment =NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(255, 37, 0);
    _titleLb.font = BFont(21);

    _englishLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+5, width-35, 20)];
    [_backIV addSubview:_englishLb];
    _englishLb.textColor = LH_RGBCOLOR(255, 210, 210);
    _englishLb.font = BFont(18);
    _englishLb.textAlignment = NSTextAlignmentLeft;

    _classIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 65, width-55, 90)];
    [_backIV addSubview:_classIV];
    _classIV.backgroundColor = LH_RandomColor;

    _goinBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 140, 72, 30)];
    [_backIV addSubview:_goinBtn];
    _goinBtn.backgroundColor = LH_RGBCOLOR(255, 54, 54);
    _goinBtn.titleLabel.font = MFont(13);
    [_goinBtn setTitle:@"去逛逛 >" forState:BtnNormal];
    [_goinBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];

}

-(void)setModel:(YPromotionClassModel *)model{
    _titleLb.text = model.className;
    _englishLb.text = model.englishclass;
    [_classIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.classUrl]] placeholderImage:MImage(goodPlachorName)];
    if (self.tag) {
        _titleLb.textColor = LH_RGBCOLOR(255, 84, 0);
        _englishLb.textColor = LH_RGBCOLOR(255, 218, 202);
        _goinBtn.backgroundColor = LH_RGBCOLOR(255, 89, 5);
    }
}

-(void)setImageName:(NSString *)imageName{
    _backIV.image = MImage(imageName);
}

@end
