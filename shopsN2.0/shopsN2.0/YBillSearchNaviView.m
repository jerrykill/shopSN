//
//  YBillSearchNaviView.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBillSearchNaviView.h"

@interface YBillSearchNaviView ()<UITextFieldDelegate>

@property (strong,nonatomic) UIButton *leftBtn;

@property (strong,nonatomic) UIButton *rightBtn;

@property (strong,nonatomic)  UIView *middleV;

@property (strong,nonatomic) UIImageView *searchIV;

@end

@implementation YBillSearchNaviView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  LH_RGBCOLOR(208, 29, 27);
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.leftBtn];
    [self addSubview:self.middleV];
    [_middleV addSubview:self.searchIV];

    [_middleV addSubview:self.searchTF];

    [self addSubview:self.rightBtn];

}

#pragma mark ==懒加载==
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 29, 25, 25)];
        _leftBtn.layer.cornerRadius = 12.5;
        [_leftBtn setImage:MImage(@"back") forState:BtnNormal];
        [_leftBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];
    }
    return _leftBtn;
}

-(UIView *)middleV{
    if (!_middleV) {
        _middleV = [[UIView alloc]initWithFrame:CGRectMake((__kWidth-236*__kWidth/375)/2, 26, 236*__kWidth/375, 32)];
        _middleV.layer.cornerRadius = 16;
        _middleV.backgroundColor = LH_RGBCOLOR(166, 8, 17);
    }
    return _middleV;
}

-(UIImageView *)searchIV{
    if (!_searchIV) {
        _searchIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 14, 14)];
        _searchIV.image = MImage(@"head_search");
        _searchIV.backgroundColor = [UIColor clearColor];
    }
    return _searchIV;
}

-(UITextField *)searchTF{
    if (!_searchTF) {
        _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_searchIV)+5, 7, CGRectW(_middleV)-40, 20)];
        _searchTF.delegate = self;
        _searchTF.font = MFont(14);
        _searchTF.textColor = [UIColor whiteColor];
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"搜索发票号码、客户名称..."];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
        _searchTF.attributedPlaceholder = attr;
    }
    return _searchTF;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 29, 25, 25)];
        [_rightBtn setImage:MImage(@"more") forState:BtnNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_rightBtn addTarget:self action:@selector(chooseRight) forControlEvents:BtnTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.delegate searchDid:textField.text];
    return YES;
}

- (void)back{
    [self.delegate chooseBack];
}

- (void)chooseRight{
    [self.delegate rightAction];
}

@end
