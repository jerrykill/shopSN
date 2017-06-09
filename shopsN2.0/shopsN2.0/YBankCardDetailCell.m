//
//  YBankCardDetailCell.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBankCardDetailCell.h"

@interface YBankCardDetailCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *detailTF;

@end

@implementation YBankCardDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 16, 80, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(16);

    _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+10, 18, __kWidth-120, 20)];
    [self addSubview:_detailTF];
    _detailTF.textAlignment = NSTextAlignmentLeft;
    _detailTF.textColor = __TextColor;
    _detailTF.font = MFont(16);
    _detailTF.delegate = self;

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, __kWidth, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.delegate getInputTFdetail:textField.text index:self.tag];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.delegate getInputTFdetail:textField.text index:self.tag];
    return YES;
}

-(void)setTitle:(NSString *)title{
    _title= title;
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detail = detail;
    _detailTF.text = _detail;
}

-(void)setPlachorText:(NSString *)plachorText {
    _detailTF.placeholder = plachorText;
}

@end
