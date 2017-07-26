//
//  YSearchPushView.m
//  shopsN
//
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSearchPushView.h"

@interface YSearchPushView ()<UITextFieldDelegate>


@end

@implementation YSearchPushView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __DefaultColor;
        [self initView];
    }
    return self;
}

- (void)initView{
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(10, 26, __kWidth-60, 32)];
    [self addSubview:backV];
    backV.backgroundColor = LH_RGBCOLOR(166, 21, 17);
    backV.layer.cornerRadius = 16;

    UIImageView *searchIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
    searchIV.image = MImage(@"head_search");
    [backV addSubview:searchIV];

    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(searchIV)+5, 6, CGRectW(backV)-40, 20)];
    [backV addSubview:_searchTF];
    _searchTF.delegate = self;
    _searchTF.font = MFont(15);
    _searchTF.textColor = LH_RGBCOLOR(229, 151, 156);
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"请输入商品名称..."];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
    _searchTF.attributedPlaceholder = attr;

    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(backV), 26, 50, 32)];
    [self addSubview:cancelBtn];
    cancelBtn.titleLabel.font = MFont(15);
    [cancelBtn setTitle:@"取消" forState:BtnNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:BtnTouchUpInside];

}

-(void)cancel{
    [self.delegate chooseBack];
}

#pragma mark ==UITextfiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate searchDid:textField.text];;
    }else{
        [textField becomeFirstResponder];
    }
    return YES;
}

@end
