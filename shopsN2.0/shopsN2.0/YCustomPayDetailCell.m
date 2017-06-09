//
//  YCustomPayDetailCell.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCustomPayDetailCell.h"

@interface YCustomPayDetailCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLabel;

@property (strong,nonatomic) UITextField *detailTextFiled;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YCustomPayDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailTextFiled];
    [self addSubview:self.lineIV];

}


#pragma mark ==懒加载==
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 75, 20)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = __DTextColor;
        _titleLabel.font = MFont(15);
    }
    return _titleLabel;
}

- (UITextField *)detailTextFiled{
    if (!_detailTextFiled) {
        _detailTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLabel), 12.5, __kWidth-105, 25)];
        _detailTextFiled.font = MFont(15);
        _detailTextFiled.textAlignment = NSTextAlignmentLeft;
        _detailTextFiled.textColor = __DTextColor;
        _detailTextFiled.delegate = self;
    }
    return _detailTextFiled;
}

- (UIImageView *)lineIV {
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}


-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
    _titleLabel.frame = CGRectMake(10, 15, _title.length*15, 20);
    _detailTextFiled.frame = CGRectMake(CGRectXW(_titleLabel), 12.5, __kWidth-45-(_title.length*15), 25);
}

-(void)setDetail:(NSString *)detail{
    _detailTextFiled.placeholder = [NSString stringWithFormat:@"请输入%@...",detail];
}


#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate getDetail:_detailTextFiled.text index:self.tag];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
