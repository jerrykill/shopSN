//
//  YPromotionClassView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionClassView.h"
#import "YPromotionTagView.h"

@interface YPromotionClassView()

@property (strong,nonatomic)  UIImageView *backIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *englishLb;

@property (strong,nonatomic) UIImageView *classIV;

@property (strong,nonatomic) UIButton*goinBtn;

@end

@implementation YPromotionClassView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = __kWidth/2;
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, width-15, 350)];
    [self addSubview:_backIV];
    _backIV.userInteractionEnabled = YES;
    _backIV.contentMode = UIViewContentModeScaleAspectFit;
    _backIV.image = MImage(@"Promotions_hot1");

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, width-40, 22)];
    [_backIV addSubview:_titleLb];
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.textAlignment =NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(255, 144, 0);
    _titleLb.font = BFont(21);

    _englishLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+5, width-35, 20)];
    [_backIV addSubview:_englishLb];
    _englishLb.textColor = LH_RGBCOLOR(255, 232, 183);
    _englishLb.font = BFont(18);

    _classIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 130, width-55, 180)];
    [_backIV addSubview:_classIV];
    _classIV.backgroundColor = LH_RandomColor;

    _goinBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 320, 72, 30)];
    [_backIV addSubview:_goinBtn];
    _goinBtn.backgroundColor = LH_RGBCOLOR(255, 170, 0);
    _goinBtn.titleLabel.font = MFont(13);
    [_goinBtn setTitle:@"去逛逛 >" forState:BtnNormal];
    [_goinBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    
}

-(void)setModel:(YPromotionClassModel *)model{
    _model =model;
    _titleLb.text = model.className;
    _englishLb.text = model.englishclass;
    [_classIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.classUrl]] placeholderImage:MImage(goodPlachorName)];
    for (int i=0; i<model.tagArr.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTag:)];
        YPromotionTagView *tagV = [[YPromotionTagView alloc]initWithFrame:CGRectMake((i%2)*60+10, CGRectYH(_englishLb)+5+(i/2)*25, 50, 20)];
        tagV.userInteractionEnabled = YES;
        [_backIV addSubview:tagV];
        [_backIV bringSubviewToFront:tagV];
        tagV.tag = i+22;
        [tagV addGestureRecognizer:tap];
        tagV.title = model.tagArr[i];
    }
}



-(void)chooseTag:(UITapGestureRecognizer*)sender{
    YPromotionTagView *tagV=(YPromotionTagView *)sender.view;
    [self.delegate chooseTagV:_model.tagArr[tagV.tag-22]];
}

@end
