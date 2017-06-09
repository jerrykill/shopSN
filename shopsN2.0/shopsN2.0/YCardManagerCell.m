//
//  YCardManagerCell.m
//  shopsN
//
//  Created by imac on 2017/1/11.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCardManagerCell.h"

@interface YCardManagerCell ()

@property (strong,nonatomic) UIImageView *cardIV;

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UIButton *deleteBtn;

@property (strong,nonatomic) UIButton *changeBtn;

@end

@implementation YCardManagerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *headIV= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 5)];
    [self addSubview:headIV];
    headIV.backgroundColor = __BackColor;


    _cardIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 45, 30)];
    [self addSubview:_cardIV];
    _cardIV.image = MImage(@"Bank_card");
    

    _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_cardIV)+20, 15, __kWidth-90, 20)];
    [self addSubview:_nameLb];
    _nameLb.textAlignment = NSTextAlignmentLeft;
    _nameLb.textColor = __DTextColor;
    _nameLb.font = BFont(16);

    _numLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_cardIV)+20, CGRectYH(_nameLb)+15, __kWidth-90, 20)];
    [self addSubview:_numLb];
    _numLb.textAlignment = NSTextAlignmentLeft;
    _numLb.textColor = __DTextColor;
    _numLb.font = BFont(15);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 84, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(lineIV), (__kWidth-1)/2, 45)];
    [self addSubview:_deleteBtn];
    _deleteBtn.titleLabel.font = MFont(16);
    _deleteBtn.tag = 0;
    [_deleteBtn setTitle:@"删除" forState:BtnNormal];
    [_deleteBtn setTitleColor:__TextColor forState:BtnNormal];
    [_deleteBtn setImage:MImage(@"card_delete") forState:BtnNormal];
    [_deleteBtn addTarget:self action:@selector(cardAction:) forControlEvents:BtnTouchUpInside];
    _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);


    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-1)/2, CGRectYH(lineIV)+8, 1, 25)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor= __BackColor;

    _changeBtn =[[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(bottomIV), CGRectYH(lineIV), (__kWidth-1)/2, 45)];
    [self addSubview:_changeBtn];
    _changeBtn.titleLabel.font = MFont(16);
    _changeBtn.tag = 1;
    [_changeBtn setTitle:@"修改" forState:BtnNormal];
    [_changeBtn setTitleColor:__TextColor forState:BtnNormal];
    [_changeBtn setImage:MImage(@"Cart_edit") forState:BtnNormal];
    [_changeBtn addTarget:self action:@selector(cardAction:) forControlEvents:BtnTouchUpInside];
    _changeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _changeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);

}

-(void)cardAction:(UIButton*)sender{
    [self.delegate cardManager:sender.tag index:self.tag];
}

-(void)setName:(NSString *)name{
    _nameLb.text = name;
}

-(void)setNum:(NSString *)num{
    NSString *str = [num substringWithRange:NSMakeRange(num.length-4, 4)];
    _numLb.text = [NSString stringWithFormat:@"****%@",str];
}

@end
