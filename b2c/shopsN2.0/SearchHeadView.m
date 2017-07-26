
//  SearchHeadView.m
//  shopsN
//
//  Created by imac on 2016/11/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "SearchHeadView.h"

@interface SearchHeadView()<UITextFieldDelegate>

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UITextField *searchTF;

@end

@implementation SearchHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LH_RGBCOLOR(207, 29, 27);
        [self initView];
        _isEdit = YES;
    }
    return self;
}

-(void)initView{
    _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 32, 75, 20)];
    [self addSubview:_logoIV];
    _logoIV.image = MImage(@"head_logo");
    _logoIV.contentMode = UIViewContentModeScaleAspectFit;

    UIView *middleV = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+15, 25, __kWidth-150, 30)];
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
    NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"搜索商品..."];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
    _searchTF.attributedPlaceholder = attr;
    
    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 29, 25, 25)];
    [self addSubview:_messageBtn];
    [_messageBtn setImage:MImage(@"more") forState:BtnNormal];
    [_messageBtn addTarget:self action:@selector(seeMessage) forControlEvents:BtnTouchUpInside];

}

-(void)seeMessage{
    [self.delegate lookMessage];
}

-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
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
