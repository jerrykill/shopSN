//
//  YGoodDetailWayColorCell.m
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailWayColorCell.h"

@interface YGoodDetailWayColorCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YGoodDetailWayColorCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, __kWidth-50, 16)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _titleLb.font = MFont(16);


}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLb.text = title;

}

-(void)setCheck:(NSString *)check{
    _check = check;
}

-(void)setBtnArr:(NSMutableArray<YSSizeModel *> *)BtnArr{
    _BtnArr =BtnArr;
    _btnArr = [NSMutableArray array];
    for (int i=0; i<_BtnArr.count; i++) {
        YSSizeModel *model = _BtnArr[i];
        NSInteger c = (__kWidth-50)/60;
        UIButton *typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(25+(i%c)*50, CGRectYH(_titleLb)+9+49*(i/c), 46, 40)];
        [self addSubview:typeBtn];
        typeBtn.backgroundColor = [UIColor whiteColor];
        typeBtn.titleLabel.font = MFont(15);
        typeBtn.layer.cornerRadius = 4;
        typeBtn.layer.borderWidth = 1;
        typeBtn.layer.borderColor = __BackColor.CGColor;
        if (model.name.length>5) {
            [typeBtn.titleLabel adjustsFontSizeToFitWidth];
        }
        [typeBtn setTitle:model.name forState:BtnNormal];
        [typeBtn setTitleColor:__DTextColor forState:BtnNormal];
        [typeBtn setTitle:model.name forState:BtnStateSelected];
        [typeBtn setTitleColor:__DefaultColor forState:BtnStateSelected];
        if ([model.name isEqualToString:_check]) {
            typeBtn.selected = YES;
            typeBtn.layer.borderColor = __DefaultColor.CGColor;
            typeBtn.userInteractionEnabled = NO;
        }
        typeBtn.tag = i+33;
        [typeBtn addTarget:self action:@selector(chooseType:) forControlEvents:BtnTouchUpInside];
        [_btnArr addObject:typeBtn];
    }
    NSInteger c = (__kWidth-50)/60;
    
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(25, CGRectYH(_titleLb)+49*(_BtnArr.count/c+1)+19, __kWidth-50, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}


-(void)chooseType:(UIButton*)sender{
    for (UIButton *btn in _btnArr) {
        if (btn.tag == sender.tag) {
            btn.selected = !btn.selected;
            btn.userInteractionEnabled = NO;
            btn.layer.borderColor = __DefaultColor.CGColor;
        }else{
            btn.selected = NO;
            btn.userInteractionEnabled = YES;
            btn.layer.borderColor = __BackColor.CGColor;
        }
    }
    [self.delegate chooseType:self.tag index:(sender.tag-33)];
}

@end
