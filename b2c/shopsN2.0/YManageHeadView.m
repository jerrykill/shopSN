
//
//  YManageHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YManageHeadView.h"

@interface YManageHeadView ()<UITextFieldDelegate>

@property (strong,nonatomic) UIView *searchV;

@property (strong,nonatomic)  UIImageView *searchIV;

@property (strong,nonatomic) UITextField *searchTF;

@property (strong,nonatomic) UIButton *searchBtn;

@end

@implementation YManageHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.searchV];
    [_searchV addSubview:self.searchIV];
    [_searchV addSubview:self.searchTF];
    [self addSubview:self.searchBtn];


}

#pragma mark ==懒加载==
-(UIView *)searchV{
    if (!_searchV) {
        _searchV = [[UIView alloc]initWithFrame:CGRectMake(10,10, __kWidth-60, 35)];
        _searchV.backgroundColor = [UIColor whiteColor];
        _searchV.layer.cornerRadius =5;
        _searchV.layer.borderWidth = 1;
        _searchV.layer.borderColor = LH_RGBCOLOR(233, 233, 233).CGColor;
        _searchV.userInteractionEnabled = YES;
    }
    return _searchV;
}

-(UIImageView *)searchIV{
    if (!_searchIV) {
        _searchIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 15, 15)];
        _searchIV.image = MImage(@"sousuo");
        _searchIV.backgroundColor = [UIColor clearColor];
    }
    return _searchIV;
}

-(UITextField *)searchTF{
    if (!_searchTF) {
        _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_searchIV)+5, 8, CGRectW(_searchV)-40, 20)];
        _searchTF.delegate = self;
        _searchTF.font = MFont(13);
        _searchTF.textColor = HEXCOLOR(0x333333);
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTF.placeholder = @"商品名称、订单编号";
        _searchTF.userInteractionEnabled = YES;
    }
    return _searchTF;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_searchV), 10, 50, 35)];
        _searchBtn.titleLabel.font = MFont(17);
        [_searchBtn setTitle:@"搜索" forState:BtnNormal];
        [_searchBtn setTitleColor:__DTextColor forState:BtnNormal];
        [_searchBtn addTarget:self action:@selector(doSearch) forControlEvents:BtnTouchUpInside];
        _searchBtn.userInteractionEnabled = YES;
    }
    return _searchBtn;
}

-(void)doSearch{
    [_searchTF resignFirstResponder];
}

#pragma mark ==UITextfiled Delegate==
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate searchDid:textField.text];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
