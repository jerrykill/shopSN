//
//  YFilterHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YFilterHeadView.h"

@interface YFilterHeadView ()<UITextFieldDelegate>

@property (strong,nonatomic) UIButton *leftBtn;



@property (strong,nonatomic) UIButton *messageBtn;

@end

@implementation YFilterHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = LH_RGBCOLOR(208, 17, 27);
        [self initView];
    }
    return self;
}

-(void)initView{
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 29, 25, 25)];
    [self addSubview:_leftBtn];
    _leftBtn.layer.cornerRadius = 12.5;
    [_leftBtn setImage:MImage(@"back") forState:BtnNormal];
    [_leftBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];

    UIView *middleV = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(_leftBtn)+15, 25, __kWidth-100, 30)];
    [self addSubview:middleV];
    middleV.layer.cornerRadius = 15;
    middleV.backgroundColor = LH_RGBCOLOR(165, 21, 17);

    UIImageView *searchIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 15, 15)];
    searchIV.image = MImage(@"sousuo");
    [middleV addSubview:searchIV];
    searchIV.backgroundColor = [UIColor clearColor];

    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(searchIV)+5, 7, CGRectW(middleV)-40, 20)];
    [middleV addSubview:_searchTF];
    _searchTF.delegate = self;
    _searchTF.font = MFont(14);
    _searchTF.textColor = [UIColor whiteColor];
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.placeholder = @"搜索商品...";

    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 29, 25, 25)];
    [self addSubview:_messageBtn];
    [_messageBtn setImage:MImage(@"more") forState:BtnNormal];
    [_messageBtn addTarget:self action:@selector(seeMessage) forControlEvents:BtnTouchUpInside];

}

-(void)back{
    [self.delegate makeBack];
}

-(void)seeMessage{
    [self.delegate lookMore];
}

#pragma mark ==UITextfiled Delegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (!_isEdit) {
        [self.delegate searchBegin];
        return _isEdit;
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.delegate searchDid:textField.text];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)setTitle:(NSString *)title{
    _searchTF.text = title;
}

@end
