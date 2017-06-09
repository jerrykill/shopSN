

//
//  YfeedBackOneCell.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YfeedBackOneCell.h"

@interface YfeedBackOneCell()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *typeTF;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YfeedBackOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.typeTF];
    [self addSubview:self.lineIV];


}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, 80, 16)];
        _titleLb.textColor = __TextColor;
        _titleLb.font = MFont(15);
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.text = @"反馈类型：";
    }
    return _titleLb;
}

-(UITextField *)typeTF{
    if (!_typeTF) {
        _typeTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 16, __kWidth-130, 20)];
        _typeTF.textColor= __TextColor;
        _typeTF.font = MFont(15);
        _typeTF.textAlignment = NSTextAlignmentRight;
        _typeTF.placeholder = @"请选择反馈类型";
        _typeTF.delegate = self;
    }
    return _typeTF;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}


-(void)setType:(NSString *)type{
    _typeTF.text = type;
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.delegate choosefeedType];
    return NO;
}


@end
