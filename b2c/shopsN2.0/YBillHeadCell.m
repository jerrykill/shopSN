//
//  YBillHeadCell.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBillHeadCell.h"
#import "YBillChooseView.h"

@interface YBillHeadCell()<UITextFieldDelegate>

@property (strong,nonatomic) NSMutableArray *chooseArr;

@property (strong,nonatomic)  UILabel *headLb;

@property (strong,nonatomic) UITextField *headTF;

@property (strong,nonatomic) NSString *type;

@end

@implementation YBillHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = __BackColor;
          _chooseArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    _headLb = [[UILabel alloc]initWithFrame:CGRectMake(13, 14, 80, 15)];
    [self addSubview:_headLb];
    _headLb.textAlignment = NSTextAlignmentLeft;
    _headLb.textColor =LH_RGBCOLOR(102, 102, 102);
    _headLb.font = MFont(14);
    _headLb.text = @"发票抬头";

    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(0, 35, __kWidth, 90)];
    [self addSubview:mainV];
    mainV.backgroundColor = [UIColor whiteColor];

    NSArray *dataArr= @[@"个人",@"单位"];
    for (int i=0; i<2; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseType:)];
        YBillChooseView *chooseV = [[YBillChooseView alloc]initWithFrame:CGRectMake(i%2*__kWidth/2+15, i/2*45, __kWidth/2, 45)];
        [mainV addSubview:chooseV];
        chooseV.title =dataArr[i];
        chooseV.tag =i;
        [_chooseArr addObject:chooseV];
        [chooseV addGestureRecognizer:tap];
    }
    
    _headTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, __kWidth-20, 35)];
    [self addSubview:_headTF];
    _headTF.layer.cornerRadius= 4;
    _headTF.backgroundColor =__BackColor;
    _headTF.placeholder = @"(非个人)请输入发票抬头";
    _headTF.font = MFont(13);
    _headTF.delegate = self;

}

-(void)setHeadType:(NSString *)headType{
    for (YBillChooseView *chooseV in _chooseArr) {
        if ([headType isEqualToString:chooseV.title]) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}
-(void)setHeader:(NSString *)header{
    _headTF.text = header;
}

-(void)chooseType:(UITapGestureRecognizer*)tap{
    for (YBillChooseView *chooseV in _chooseArr) {
        if (chooseV.tag==tap.view.tag) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
            _type = chooseV.title;
            if (!IsNilString(_headTF.text)&&chooseV.tag ==1) {
                [self.delegate chooseHeadType:_type head:_headTF.text];
            }else if (chooseV.tag ==0){
                _headTF.text = @"";
                [self.delegate chooseHeadType:_type head:@""];
            }
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
    if (tap.view.tag ==0) {
        _headTF.userInteractionEnabled = NO;
    }else{
        _headTF.userInteractionEnabled = YES;
        [_headTF becomeFirstResponder];
    }
}

#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (IsNilString(_type)) {
        [SXLoadingView showAlertHUD:@"请选择类型" duration:1];
    }else{
        [self.delegate chooseHeadType:_type head:textField.text];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

@end
