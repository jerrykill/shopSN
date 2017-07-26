//
//  YGoodCell.m
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodCell.h"
#import "YGoodListBottomView.h"

@interface YGoodCell()<YGoodListBottomViewDelegate>
//商品图片
@property (strong,nonatomic) UIImageView *goodIV;
//标题
@property (strong,nonatomic) UILabel *titleLb;
//价格
@property (strong,nonatomic) UILabel *priceLb;
//评论人数
@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) YGoodListBottomView *listBottomV;

@end

@implementation YGoodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, __kWidth*210/750, 90)];
    [self addSubview:_goodIV];
    _goodIV.contentMode = UIViewContentModeScaleAspectFit;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 15, __kWidth*540/750-40, 40)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.numberOfLines = 2;
    _titleLb.textColor = __TextColor;
    _titleLb.font = MFont(15);
    _titleLb.backgroundColor = [UIColor whiteColor];

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+14, 200*__kWidth/750, 15)];
    [self addSubview:_priceLb];
    _priceLb.textColor = LH_RGBCOLOR(241, 47, 47);
    _priceLb.font = MFont(15);
    _priceLb.textAlignment = NSTextAlignmentLeft;
    _priceLb.backgroundColor = [UIColor whiteColor];

    _countLb = [[UILabel alloc]initWithFrame:CGRectMake(550*__kWidth/750-10, CGRectYH(_titleLb)+15, 200*__kWidth/750, 14)];
    [self addSubview:_countLb];
    _countLb.textColor = LH_RGBCOLOR(180, 180, 180);
    _countLb.backgroundColor = [UIColor whiteColor];
    _countLb.font = MFont(14);
    _countLb.textAlignment = NSTextAlignmentRight;
    _countLb.hidden = YES;

    _listBottomV = [[YGoodListBottomView alloc]initWithFrame:CGRectMake(__kWidth-190, CGRectYH(_countLb)+15, 175, 28)];
    [self addSubview:_listBottomV];
    _listBottomV.delegate = self;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth*260/750, 129, __kWidth*490/750, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

-(void)setModel:(YGoodsModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:_model.goodTitle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
     [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_model.goodTitle length])];
    _titleLb.attributedText = attri;
    _priceLb.text = [NSString stringWithFormat:@"¥%@",_model.goodMoney];
    if (_model.isBuy) {
        _countLb.text = [NSString stringWithFormat:@"已购%@件",_model.goodeValuateCount];
        _countLb.hidden = NO;
    }else{
        if (_model.goodeValuateCount) {
           _countLb.text = [NSString stringWithFormat:@"已有%@人评论",_model.goodeValuateCount];
           _countLb.hidden = NO;
        }
    }
}

-(void)GoodListAction:(NSInteger)sender{
    [self.delegate GoodListAction:sender index:self.tag];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *subView in self.subviews) {

        if ([NSStringFromClass([subView class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            UIView *deleteConfirmationView = subView.subviews[0];
            for (UIView *deleteView in deleteConfirmationView.subviews) {
                NSLog(@"%@",deleteConfirmationView.subviews);
                UIImageView *collectIV = [[UIImageView alloc]initWithFrame:CGRectMake(10,-10, 30, 30)];
                collectIV.image = MImage(@"collect_cancel");
                collectIV.contentMode = UIViewContentModeScaleAspectFit;
                [deleteView addSubview:collectIV];

                UILabel *titeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(collectIV)+5, 50, 15)];
                [deleteView addSubview:titeLb];
                titeLb.textAlignment = NSTextAlignmentCenter;
                titeLb.font = MFont(12);
                titeLb.textColor = [UIColor whiteColor];
                titeLb.text = @"取消收藏";
            }

        }
    }
}

@end
