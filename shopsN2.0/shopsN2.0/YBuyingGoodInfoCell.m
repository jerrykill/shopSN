//
//  YBuyingGoodInfoCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingGoodInfoCell.h"

@interface YBuyingGoodInfoCell ()<UITextViewDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *plachorLb;

@property (strong,nonatomic) UITextView *inputTV;


@end

@implementation YBuyingGoodInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}
-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.inputTV];

    [_inputTV addSubview:self.plachorLb];

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 134, __kWidth, 5)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
    
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 100, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.font = MFont(15);
        _titleLb.text = @"说明：";
    }
    return _titleLb;
}

-(UITextView *)inputTV{
    if (!_inputTV) {
        _inputTV = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+8, __kWidth-20, 60)];
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
        _plachorLb.font = MFont(12);
        _plachorLb.text = @"买家没有留言";
    }
    return _plachorLb;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setWarn:(NSString *)warn{
    _plachorLb.text = warn;
}

-(void)setInfo:(NSString *)info{
    _inputTV.text = info;
}
#pragma mark ==UITextViewDelegate==
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _plachorLb.hidden = YES;
    }else{
        _plachorLb.hidden = NO;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
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
        [self.delegate getInfoDetail:textView.text];
    }
    return YES;
}




@end
