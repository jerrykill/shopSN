//
//  YConsDetailPutView.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YConsDetailPutView.h"

@interface YConsDetailPutView ()<UITextViewDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextView *inputTV;

@property (strong,nonatomic) UILabel *plachorLb;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YConsDetailPutView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.inputTV];

    [_inputTV addSubview:self.plachorLb];

    [self addSubview:self.bottomIV];



}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, 100, 15)];

        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.font = MFont(15);
        _titleLb.text = @"详细备注：";
    }
    return _titleLb;
}

-(UITextView *)inputTV{
    if (!_inputTV) {
        _inputTV = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+8, __kWidth-20, 160)];
        _inputTV.textAlignment = NSTextAlignmentLeft;
        _inputTV.font = MFont(15);
        _inputTV.delegate = self;
    }
    return _inputTV;
}

-(UILabel *)plachorLb{
    if (!_plachorLb) {
        _plachorLb = [[UILabel alloc]initWithFrame:CGRectMake(11, 7, 200, 15)];
        _plachorLb.textAlignment = NSTextAlignmentLeft;
        _plachorLb.textColor = LH_RGBCOLOR(198, 198, 198);
        _plachorLb.font = MFont(15);
        _plachorLb.text = @"请输入补充耗材的详细备注...";
    }
    return _plachorLb;
}

-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 220, __kWidth, 5)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}

#pragma mark ==UITextViewDelegate==
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _plachorLb.hidden = YES;
    }else{
        _plachorLb.hidden = NO;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    if (textView.text.length>1) {
        _plachorLb.hidden = YES;
    }else{
        _plachorLb.hidden = NO;
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (!IsNilString(textView.text)) {
        [self.delegate getConsInfo:textView.text];
    }
    return YES;
}

@end
