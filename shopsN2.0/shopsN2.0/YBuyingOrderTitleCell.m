//
//  YBuyingOrderTitleCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingOrderTitleCell.h"

@interface YBuyingOrderTitleCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *detailTF;


@end

@implementation YBuyingOrderTitleCell

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
    [self addSubview:self.detailTF];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb =[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UITextField *)detailTF{
    if (!_detailTF) {
        _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 12, __kWidth-115, 20)];
        _detailTF.textAlignment = NSTextAlignmentRight;
        _detailTF.textColor = __DTextColor;
        _detailTF.font = MFont(16);
        _detailTF.delegate = self;
    }
    return _detailTF;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailTF.text = detail;
}

-(void)setPlachor:(NSString *)plachor{
    _detailTF.placeholder = plachor;
}

#pragma mark ==UITextfiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (!IsNilString(textField.text)) {
        [self.delegate Getdetail:textField.text Index:(self.tag-100)];
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(void)setEdit:(BOOL)edit{
    _detailTF.userInteractionEnabled = NO;
}
@end
