//
//  YfeedBackThreeCell.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YfeedBackThreeCell.h"

@interface YfeedBackThreeCell()<UITextViewDelegate>

@property (strong,nonatomic) UILabel *warnLb;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YfeedBackThreeCell

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
    [self addSubview:self.detailTV];
    [_detailTV addSubview:self.warnLb];
}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, __kWidth-30, 16)];
        _titleLb.textColor = __TextColor;
        _titleLb.font = MFont(15);
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.text = @"反馈内容：";
    }
    return _titleLb;
}

-(UITextView *)detailTV{
    if (!_detailTV) {
        _detailTV = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectYH(_titleLb)+15, __kWidth-30, 160)];
        _detailTV.delegate = self;
        _detailTV.backgroundColor = [UIColor whiteColor];
        _detailTV.font = MFont(15);
    }
    return _detailTV;
}

-(UILabel *)warnLb{
    if (!_warnLb) {
        _warnLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, 130, 16)];
        _warnLb.backgroundColor = [UIColor clearColor];
        _warnLb.textColor = LH_RGBCOLOR(207, 207, 207);
        _warnLb.font = MFont(15);
        _warnLb.textAlignment = NSTextAlignmentLeft;
        _warnLb.text = @"请输入反馈内容";
    }
    return _warnLb;
}


#pragma mark ==UITextViewDelegate==
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _warnLb.hidden = YES;
    }else{
        _warnLb.hidden = NO;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    if (textView.text.length>0) {
        _warnLb.hidden = YES;
    }else{
        _warnLb.hidden = NO;
    }
    return YES;
}

@end
