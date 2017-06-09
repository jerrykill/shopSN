//
//  YDrawBackMoneyCell.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YDrawBackMoneyCell.h"

#define NUMBERS @"0123456789."
@interface YDrawBackMoneyCell ()<UITextFieldDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextField *moneyTF;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YDrawBackMoneyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
         self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self initView];
    }
    return self;
}

- (void)initView{
    for (int i=0; i<2; i++) {
        UIView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*137, __kWidth, 10)];
        [self addSubview:bottomIV];
        bottomIV.backgroundColor = __BackColor;
    }

    [self addSubview:self.titleLb];
    [self addSubview:self.moneyTF];


    UIButton *UnitsBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_moneyTF), 80, 20, 40)];
    [self addSubview:UnitsBtn];
    UnitsBtn.titleLabel.font = MFont(13);
    [UnitsBtn setTitle:@"元" forState:BtnNormal];
    [UnitsBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];

    [self addSubview:self.detailLb];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, __kWidth-20, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
        _titleLb.text = @"申请金额";
    }
    return _titleLb;
}

-(UITextField *)moneyTF{
    if (!_moneyTF) {
        _moneyTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+17, 120, 40)];
        _moneyTF.layer.cornerRadius = 5;
        _moneyTF.layer.borderWidth = 1;
        _moneyTF.layer.borderColor = __BackColor.CGColor;
        _moneyTF.font = MFont(18);
        _moneyTF.textAlignment = NSTextAlignmentCenter;
        _moneyTF.textColor = __DefaultColor;
        _moneyTF.delegate = self;
        _moneyTF.text = @"0.00";
    }
    return _moneyTF;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_moneyTF)+8, __kWidth-20, 15)];
        _detailLb.textAlignment =NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _detailLb.font = MFont(13);
    }
    return _detailLb;
}

-(void)setMoney:(NSString *)money{
    _money = money;
    
}

- (void)setApplyMoney:(NSString *)applyMoney {
    if (applyMoney.floatValue) {
        _moneyTF.text = applyMoney;
    }
}

-(void)setFright:(NSString *)fright{
    NSString *str = [NSString stringWithFormat:@"您最多可申请%.2f元，含发货运费%@元",[_money floatValue],fright];
    _detailLb.text = str;
}


#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [self.delegate changeMoneyFrame:270];
    if ([textField.text floatValue]==0) {
        textField.text = nil;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
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
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (IsNilString(textField.text)) {
        [SXLoadingView showAlertHUD:@"申请退款金额不可为空" duration:1.5];
        textField.text = @"0.00";
    }else{
        NSString *money = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
        textField.text = money;
        if (money.floatValue>_money.floatValue) {
            [SXLoadingView showAlertHUD:@"金额超限" duration:SXLoadingTime];
        }else{
            [self.delegate getApplyMoney:money];
        }
    }
}


@end
