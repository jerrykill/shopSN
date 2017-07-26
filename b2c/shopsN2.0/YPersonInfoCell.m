//
//  YPersonInfoCell.m
//  shopsN
//
//  Created by imac on 2017/1/12.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonInfoCell.h"

@interface YPersonInfoCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *detailTF;


@end

@implementation YPersonInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(15);
    _titleLb.textColor = LH_RGBCOLOR(61, 66, 69);

    _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, __kWidth-135, 20)];
    [self addSubview:_detailTF];
    _detailTF.textAlignment = NSTextAlignmentRight;
    _detailTF.textColor = LH_RGBCOLOR(155, 155, 155);
    _detailTF.font= MFont(16);
    _detailTF.placeholder = @"请填写";
    _detailTF.delegate = self;

}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    [self.delegate changePersonInfo:textField.text index:self.tag];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.tag==1||self.tag ==5) {
        return NO;
    }
    return YES;
}

-(void)setDetail:(NSString *)detail{
    _detailTF.text = detail;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
    _detailTF.placeholder = [NSString stringWithFormat:@"请填写%@",title];
}



@end
