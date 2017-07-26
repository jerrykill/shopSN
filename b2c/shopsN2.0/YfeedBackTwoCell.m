//
//  YfeedBackTwoCell.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YfeedBackTwoCell.h"

@interface YfeedBackTwoCell ()<UITextFieldDelegate>

@property (strong,nonatomic)  UILabel *titleLb;

@property (strong,nonatomic)  UIImageView *lineIV;
@end

@implementation YfeedBackTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.connectTF];
    [self addSubview:self.lineIV];

}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, 80, 16)];
        _titleLb.textColor = __TextColor;
        _titleLb.font = MFont(15);
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.text = @"联系方式：";
    }
    return _titleLb;
}

-(UITextField *)connectTF{
    if (!_connectTF) {
        _connectTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 15, __kWidth-110, 20)];

        _connectTF.placeholder = @"请输入手机号或邮箱等";
        _connectTF.textAlignment = NSTextAlignmentLeft;
        _connectTF.font =MFont(15);
        _connectTF.delegate = self;

    }
    return _connectTF;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate connectWay:textField.text];
    }
    return YES;
}


@end
