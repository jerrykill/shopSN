//
//  YSecondSearchView.m
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSecondSearchView.h"

@interface YSecondSearchView()<UITextFieldDelegate>

@property (strong,nonatomic) UITextField *searchTF;

@end


@implementation YSecondSearchView

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
    [self addSubview:logoV];
    logoV.backgroundColor = __DefaultColor;
    logoV.userInteractionEnabled = YES;

    UIImageView *logoIV= [[UIImageView alloc]initWithFrame:CGRectMake(5, 12, 74, 17)];
    [logoV addSubview:logoIV];
    logoIV.image = MImage(@"head_logo");
    logoIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBack)];
    [logoIV addGestureRecognizer:tap];

    //搜索
    UIView *searchV = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(logoV)+6, CGRectYH(backV)+7, __kWidth-160, 30)];
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

    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(searchV)+30, CGRectYH(backV)+7, 30, 30)];
    [self addSubview:moreBtn];
    [moreBtn setImage:MImage(@"head_more") forState:BtnNormal];
    [moreBtn addTarget:self action:@selector(chooseMore) forControlEvents:BtnTouchUpInside];
}

-(void)chooseMore{
    [self.delegate chooseRight];
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate search:textField.text];
    return NO;
}

- (void)chooseBack {
    [self.delegate chooseNaviback];
}

@end
