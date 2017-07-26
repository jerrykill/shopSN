//
//  YGoodShopOneCell.m
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodShopOneCell.h"

@interface YGoodShopOneCell()

@property (strong,nonatomic) UIButton *chooseBtn;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UIButton *numBtn;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UIButton *deleteBtn;

@end

@implementation YGoodShopOneCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 40, 80)];
    [self addSubview:_chooseBtn];
    [_chooseBtn setImage:MImage(@"Cart_off") forState:BtnNormal];
    [_chooseBtn setImage:MImage(@"Cart_on") forState:BtnStateSelected];
    _chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _chooseBtn.layer.cornerRadius = 10;
    [_chooseBtn addTarget:self action:@selector(choose:) forControlEvents:BtnTouchUpInside];

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_chooseBtn), 10, 80, 80)];
    [self addSubview:_goodIV];
//    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.layer.borderColor = __BackColor.CGColor;
    _goodIV.contentMode = UIViewContentModeScaleAspectFit;
    _goodIV.layer.borderWidth = 0.5;

    CGFloat width =__kWidth-130-60;

    UIButton *reduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 5, 45*width/170, 40)];
    [self addSubview:reduceBtn];
    reduceBtn.layer.cornerRadius = 4;
    reduceBtn.layer.borderWidth = 1;
    reduceBtn.layer.borderColor = __BackColor.CGColor;
    reduceBtn.titleLabel.font = MFont(15);
    [reduceBtn setTitle:@"－" forState:BtnNormal];
    [reduceBtn setTitleColor:__DTextColor forState:BtnNormal];
    [reduceBtn addTarget:self action:@selector(reduce) forControlEvents:BtnTouchUpInside];

    _numBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(reduceBtn), 5, 80*width/170, 40)];
    [self addSubview:_numBtn];
    _numBtn.layer.borderColor = __BackColor.CGColor;
    _numBtn.layer.borderWidth = 1;
    _numBtn.titleLabel.font = MFont(15);
    [_numBtn setTitle:@"1" forState:BtnNormal];
    [_numBtn setTitleColor:__DTextColor forState:BtnNormal];
    _numBtn.userInteractionEnabled = NO;

    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_numBtn), 5, 45*width/170, 40)];
    [self addSubview:addBtn];
    addBtn.layer.cornerRadius = 4;
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = __BackColor.CGColor;
    addBtn.titleLabel.font = MFont(15);
    [addBtn setTitle:@"＋" forState:BtnNormal];
    [addBtn setTitleColor:__DTextColor forState:BtnNormal];
    [addBtn addTarget:self action:@selector(add) forControlEvents:BtnTouchUpInside];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseEdit)];
    UIView *textV = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_numBtn)+20, 140*width/170, 15)];
    [self addSubview:textV];
    textV.backgroundColor = [UIColor clearColor];
    [textV addGestureRecognizer:tap];

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 140*width/170, 15)];
    [textV addSubview:_detailLb];
    _detailLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _detailLb.font = MFont(12);


    UIImageView *logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(textV)+(30*width/170-10)/2, CGRectYH(_numBtn)+25, 10, 5)];
    [self addSubview:logoIV];
    logoIV.image = MImage(@"under_arrow");


    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(addBtn), 0, 60, 99)];
    [self addSubview:_deleteBtn];
    _deleteBtn.backgroundColor = __DefaultColor;
    _deleteBtn.titleLabel.font = MFont(15);
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_deleteBtn setTitle:@"删除" forState:BtnNormal];
    [_deleteBtn setImage:MImage(@"cart_delete") forState:BtnNormal];
    _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 20, 0);
    _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(30,-23, 0, 0);


    [_deleteBtn addTarget:self action:@selector(remove) forControlEvents:BtnTouchUpInside];

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 99, __kWidth, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
}

-(void)choose:(UIButton*)sender{
    sender.selected = !sender.selected;
    [self.delegate chooses:sender.selected index:self.tag];
}

#pragma mark ==减少==
-(void)reduce{
    NSInteger i = [_numBtn.titleLabel.text integerValue];
    if (i>1) {
        i--;
        [self.delegate countChange:NO index:self.tag];
    }
    [_numBtn setTitle:[NSString stringWithFormat:@"%ld",i] forState:BtnNormal];
}
#pragma mark ==增加==
-(void)add{
    NSInteger i = [_numBtn.titleLabel.text integerValue];
//    if (i<[_stock integerValue]) {
        i++;
        [self.delegate countChange:YES index:self.tag];
//    }else{
//        [SXLoadingView showAlertHUD:@"抱歉！超出库存了" duration:1.5];
//    }
    [_numBtn setTitle:[NSString stringWithFormat:@"%ld",i] forState:BtnNormal];

}

#pragma mark ==删除==
-(void)remove{
    [self.delegate deleteIndex:self.tag];
}

-(void)setModel:(YShopGoodModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _chooseBtn.selected = _model.isChoose;
    [_numBtn setTitle:_model.goodCount forState:BtnNormal];
    NSString *types = @"";
    for (YGoodTypeModel *dic in _model.goodTypeArr) {
        types = [types stringByAppendingString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@:%@ ",dic.name,dic.size]]];
    }
    _detailLb.text = types;
}

#pragma mark ==编辑==
-(void)chooseEdit{
    [self.delegate chooseEdit:self.tag];
}


@end
