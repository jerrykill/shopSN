//
//  YCustomChooseAddressCell.m
//  shopsN
//
//  Created by imac on 2017/3/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCustomChooseAddressCell.h"

@interface YCustomChooseAddressCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *addressTextfiled;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YCustomChooseAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initView];
    }
    return self;
}

- (void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.addressTextfiled];
    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 75, 20)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
        _titleLb.text = @"所在地区：";
    }
    return _titleLb;
}

-(UITextField *)addressTextfiled{
    if (!_addressTextfiled) {
        _addressTextfiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 12.5, __kWidth-120, 25)];
        _addressTextfiled.font = MFont(15);
        _addressTextfiled.textAlignment = NSTextAlignmentRight;
        _addressTextfiled.delegate = self;
        _addressTextfiled.placeholder = @"请选择地区..";
    }
    return _addressTextfiled;
}

- (UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate chooseAddress];
    return NO;
}


-(void)setAddress:(NSString *)address{
    _addressTextfiled.text = address;
}



@end
