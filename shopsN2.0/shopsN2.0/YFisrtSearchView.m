
//
//  YFisrtSearchView.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFisrtSearchView.h"

@interface YFisrtSearchView()<UITextFieldDelegate>

@property (strong,nonatomic) UITextField *searchTF;

@end

@implementation YFisrtSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 20)];
    [self addSubview:backV];
    backV.backgroundColor = LH_RGBCOLOR(65, 65, 65);

    //图标
    UIView *logoV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(backV), 85, 44)];
    [backV addSubview:logoV];
    logoV.backgroundColor = __DefaultColor;

    UIImageView *logoIV= [[UIImageView alloc]initWithFrame:CGRectMake(5, 12, 74, 17)];
    [logoV addSubview:logoIV];
    logoIV.image = MImage(@"head_logo");

    //搜索
    UIView *searchV = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(logoV)+10, CGRectYH(backV)+7, __kWidth-190, 30)];
    [self addSubview:searchV];
    searchV.backgroundColor = HEXCOLOR(0xf7f7f7);
    searchV.layer.cornerRadius = 15;

    UIImageView *searchIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 15, 15)];
    searchIV.image = MImage(@"sousuo");
    [searchV addSubview:searchIV];

    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(searchIV)+5, 5, CGRectW(searchV)-40, 20)];
    [searchV addSubview:_searchTF];
    _searchTF.delegate = self;
    _searchTF.font = MFont(14);
    _searchTF.textColor = HEXCOLOR(0x333333);
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.placeholder = @"搜索商品...";

    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-80, CGRectYH(backV)+8, 24, 24)];
    [self addSubview:_messageBtn];
    [_messageBtn setImage:MImage(@"homeNews") forState:BtnNormal];
    [_messageBtn addTarget:self action:@selector(chooseMessage) forControlEvents:BtnTouchUpInside];

    //登录
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_messageBtn)+10, CGRectYH(backV)+7, 30, 30)];
    [self addSubview:loginBtn];
    loginBtn.backgroundColor = [UIColor whiteColor];
    loginBtn.titleLabel.font = MFont(14);
    [loginBtn setTitle:@"登录" forState:BtnNormal];
    [loginBtn setTitleColor:LH_RGBCOLOR(80, 80, 80) forState:BtnNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:BtnTouchUpInside];
//    loginBtn.hidden = YES;

    UIButton *qrcodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_messageBtn)+10, CGRectYH(backV)+7, 30, 30)];
    [self addSubview:qrcodeBtn];
    [qrcodeBtn setImage:MImage(@"scan") forState:BtnNormal];
    [qrcodeBtn addTarget:self action:@selector(QRCode) forControlEvents:BtnTouchUpInside];
    qrcodeBtn.hidden = YES;
}

#pragma mark == 登录==
-(void)loginAction{
    [self.delegate login];
}
#pragma mark ==查看消息==
-(void)chooseMessage{
    [self.delegate SeeMessage];
}

#pragma mark ==扫码==
-(void)QRCode{
    [self.delegate QRCodeAction];
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate search:textField.text];
    return NO;
}

@end
