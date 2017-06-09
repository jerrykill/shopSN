//
//  YApplicationDetailCell.m
//  shopsN
//
//  Created by imac on 2016/12/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YApplicationDetailCell.h"

@interface YApplicationDetailCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *detailTF;

@property (strong,nonatomic) UIImageView *lineIV;

@property (nonatomic) CGFloat KeyHeight;

@end

@implementation YApplicationDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =  [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailTF];
    [self addSubview:self.lineIV];


}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, 80, 16)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UITextField *)detailTF{
    if (!_detailTF) {
        _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 16, __kWidth-130, 20)];
        _detailTF.backgroundColor = [UIColor whiteColor];
        _detailTF.textAlignment = NSTextAlignmentLeft;
        _detailTF.font = MFont(16);
        _detailTF.textColor = __DTextColor;
        _detailTF.delegate = self;
    }
    return _detailTF;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}


-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
   NSString *list = [NSString stringWithFormat:@"请输入%@..",title];
    _detailTF.placeholder = [list stringByReplacingOccurrencesOfString:@"：" withString:@""];
}


-(void)setFont:(NSInteger)font{
    _titleLb.font = MFont(font);
    _detailTF.font = MFont(font);
}

-(void)setDetail:(NSString *)detail{
    _detailTF.text =detail;
}

#pragma mark ==UITextfiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate getApplyDetail:textField.text Index:self.tag];
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.tag==3) {
        [self.delegate chooseArea];
        return NO;
    }
    return  YES;
}


@end
