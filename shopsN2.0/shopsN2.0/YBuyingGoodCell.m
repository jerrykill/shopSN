//
//  YBuyingGoodCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingGoodCell.h"
#define NUMBERS @"0123456789."

@interface YBuyingGoodCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *detailTF;

@end

@implementation YBuyingGoodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor =  [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.detailTF];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 75, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UITextField *)detailTF{
    if (!_detailTF) {
        _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 14, __kWidth-130, 20)];
        _detailTF.backgroundColor = [UIColor clearColor];
        _detailTF.placeholder = @"请输入详情";
        _detailTF.textAlignment = NSTextAlignmentLeft;
        _detailTF.font = MFont(16);
        _detailTF.textColor = __DTextColor;
        _detailTF.delegate = self;
    }
    return _detailTF;
}

#pragma mark ==UITextfiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate getDetailtext:textField.text Index:self.tag];
    }
    if (textField.tag==4) {
        NSString *text = textField.text;
        if (!IsNilString(text)&&![text containsString:@"¥"]) {
            textField.text = [NSString stringWithFormat:@"¥%@",text];
        }
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag<=2) {
        [self.delegate choosedata];
        return NO;
    }
    return YES;
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    if (textField.tag==4) {
        NSCharacterSet*cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {

            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入数字"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
            
        }
    }
       return YES;
}

-(void)setIsMoney:(BOOL)isMoney{
    _detailTF.textColor = __DefaultColor;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
    _detailTF.tag = self.tag;
    _detailTF.placeholder = [NSString stringWithFormat:@"请输入%@",[title stringByReplacingOccurrencesOfString:@"：" withString:@""]];
}

-(void)setDetail:(NSString *)detail{
    if (_detailTF.tag==4&&![detail containsString:@"¥"]) {
        if (!IsNilString(detail)) {
            detail = [NSString stringWithFormat:@"¥%@",detail];
        }
    }
    _detailTF.text = detail;

}

@end
