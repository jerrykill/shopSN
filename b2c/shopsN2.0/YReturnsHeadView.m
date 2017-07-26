//
//  YReturnsHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YReturnsHeadView.h"
#import "YOrderTypeButton.h"

@interface YReturnsHeadView ()<UITextFieldDelegate>

@property (strong,nonatomic) NSMutableArray *btnArr;

@property (strong,nonatomic) UITextField *searchTF;

@property (strong,nonatomic) UIButton *searchBtn;

@end

@implementation YReturnsHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _btnArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 48)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor whiteColor];

    for (int i=0; i<2; i++) {
        YOrderTypeButton *btn = [[YOrderTypeButton alloc]initWithFrame:CGRectMake((__kWidth/2-125)/2+__kWidth/2*i, 0, 125, 48)];
        [self addSubview:btn];
        btn.tag = i;
        if (i) {
            [btn setTitle:@"进度查询" forState:BtnNormal];
            [btn setTitle:@"进度查询" forState:BtnStateSelected];
        }else{
            [btn setTitle:@"售后申请" forState:BtnNormal];
            [btn setTitle:@"售后申请" forState:BtnStateSelected];
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
        }
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:BtnTouchUpInside];
        [_btnArr addObject:btn];
    }

    UIView *searchV = [[UIView alloc]initWithFrame:CGRectMake(10,48+10, __kWidth-60, 35)];
    [self addSubview:searchV];
    searchV.backgroundColor = [UIColor whiteColor];
    searchV.layer.cornerRadius =5;
    searchV.layer.borderWidth = 1;
    searchV.layer.borderColor = LH_RGBCOLOR(233, 233, 233).CGColor;
    searchV.userInteractionEnabled = YES;

    UIImageView *searchIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 15, 15)];
    searchIV.image = MImage(@"sousuo");
    [searchV addSubview:searchIV];
    searchIV.backgroundColor = [UIColor clearColor];

    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(searchIV)+5, 8, CGRectW(searchV)-40, 20)];
    [searchV addSubview:_searchTF];
    _searchTF.delegate = self;
    _searchTF.font = MFont(13);
    _searchTF.textColor = HEXCOLOR(0x333333);
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.placeholder = @"商品名称、订单编号";
    _searchTF.userInteractionEnabled = YES;

    _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(searchV), 58, 50, 35)];
    [self addSubview:_searchBtn];
    _searchBtn.titleLabel.font = MFont(17);
    [_searchBtn setTitle:@"搜索" forState:BtnNormal];
    [_searchBtn setTitleColor:__DTextColor forState:BtnNormal];
    [_searchBtn addTarget:self action:@selector(doSearch) forControlEvents:BtnTouchUpInside];
    _searchBtn.userInteractionEnabled = YES;


}

-(void)doSearch{
    [_searchTF resignFirstResponder];
}


-(void)chooseType:(UIButton*)sender{
    sender.selected = !sender.selected;
    for (YOrderTypeButton *btn in _btnArr) {
        if (btn.tag==sender.tag) {
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.colorIV.backgroundColor = [UIColor whiteColor];
            btn.userInteractionEnabled = YES;
        }
    }
    _searchTF.text = @"";
    [self.delegate chooseType:(sender.tag)];
}

#pragma mark ==UITextfiled Delegate==
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.delegate searchDid:textField.text];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
