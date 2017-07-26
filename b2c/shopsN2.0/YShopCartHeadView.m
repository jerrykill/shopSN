//
//  YShopCartHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopCartHeadView.h"

@interface YShopCartHeadView()

@property (strong,nonatomic) UIButton *allBtn;

@property (strong,nonatomic) UIButton *editBtn;

@property (strong,nonatomic) UILabel *titileLb;

@end

@implementation YShopCartHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    _allBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 90, 20)];
    [self addSubview:_allBtn];
    _allBtn.titleLabel.font = MFont(15);
    [_allBtn setTitle:@"全选" forState:BtnNormal];
    [_allBtn setTitle:@"取消全选" forState:BtnStateSelected];
    [_allBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [_allBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnStateSelected];
    [_allBtn setImage:MImage(@"Cart_off") forState:BtnNormal];
    [_allBtn setImage:MImage(@"Cart_on") forState:BtnStateSelected];
    _allBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 70);
    _allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [_allBtn addTarget:self action:@selector(chooseSelect:) forControlEvents:BtnTouchUpInside];

    _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-60, 15, 50, 15)];
    [self addSubview:_editBtn];
    _editBtn.titleLabel.font = MFont(14);
    [_editBtn setTitle:@"编辑" forState:BtnNormal];
    [_editBtn setTitle:@"完成" forState:BtnStateSelected];
    [_editBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [_editBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnStateSelected];
    [_editBtn setImage:MImage(@"Cart_edit") forState:BtnNormal];
    [_editBtn setImage:MImage(@"Cart_edit") forState:BtnStateSelected];
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:BtnTouchUpInside];
    _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -45);

    _titileLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-120)/2, 15, 120, 20)];
    [self addSubview:_titileLb];
    _titileLb.textAlignment = NSTextAlignmentCenter;
    _titileLb.font = MFont(18);
    _titileLb.textColor =  LH_RGBCOLOR(206, 28, 0);
    _titileLb.text = [NSString stringWithFormat:@"%@自营",ShortTitle];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor =__BackColor;
    
}

-(void)chooseSelect:(UIButton*)sender{
    sender.selected = !sender.selected;
    [self.delegate chooseAll:sender.selected];
}

-(void)editAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        _allBtn.hidden = YES;
    }else{
        _allBtn.hidden = NO;
    }
    [self.delegate AllEdit:sender.selected];
}

-(void)setAllChoose:(BOOL)allChoose{
    _allBtn.selected = allChoose;
}

@end
