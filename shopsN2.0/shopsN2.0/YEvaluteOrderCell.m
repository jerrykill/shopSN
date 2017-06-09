//
//  YEvaluteOrderCell.m
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YEvaluteOrderCell.h"
#import "YPutPictureView.h"
#import "YOrderEvaluteFootView.h"

@interface YEvaluteOrderCell()<UITextViewDelegate,YPutPictureViewDelegate,YOrderEvaluteFootViewDelegate>

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UITextView *inputTV;

@property (strong,nonatomic) UILabel *warnLb;

@property (strong,nonatomic) YPutPictureView *putV;

@property (strong,nonatomic) YOrderEvaluteFootView *footV;

@end

@implementation YEvaluteOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.backV];
    [_backV addSubview:self.goodIV];
    [_backV addSubview:self.inputTV];
    [_inputTV addSubview:self.warnLb];
    [_backV addSubview:self.putV];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectYH(_putV)+15, __kWidth, 1)];
    [_backV addSubview:lineIV];
    lineIV.backgroundColor = [UIColor redColor];

    [self addSubview:self.footV];

}

#pragma mark ==懒加载==
-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 7, __kWidth, 235)];
        _backV.backgroundColor = [UIColor whiteColor];
    }
    return _backV;
}

-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 88, 88)];
        _goodIV.layer.borderColor = __BackColor.CGColor;
        _goodIV.layer.borderWidth = 1;
        _goodIV.backgroundColor = LH_RandomColor;
    }
    return _goodIV;
}

-(UITextView *)inputTV{
    if (!_inputTV) {
        _inputTV = [[UITextView alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 24, __kWidth-120, 80)];
        _inputTV.backgroundColor = [UIColor clearColor];
        _inputTV.font = MFont(15);
        _inputTV.textColor = __TextColor;
        _inputTV.delegate = self;
    }
    return _inputTV;
}

-(UILabel *)warnLb{
    if (!_warnLb) {
        _warnLb = [[UILabel alloc]initWithFrame:CGRectMake(4, 5, __kWidth-130, 56)];
        _warnLb.backgroundColor = [UIColor clearColor];
        _warnLb.font = MFont(15);
        _warnLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _warnLb.textAlignment = NSTextAlignmentLeft;
        _warnLb.numberOfLines = 0;
        _warnLb.text = @"长度在10-500字之间\n 写点什么吧，您的评论可以为其他用户提供参考";
    }
    return _warnLb;
}

-(YPutPictureView *)putV{
    if (!_putV) {
        _putV = [[YPutPictureView alloc]initWithFrame:CGRectMake(0, CGRectYH(_goodIV)+38, __kWidth, 80)];
        _putV.delegate = self;
    }
    return _putV;
}

-(YOrderEvaluteFootView *)footV{
    if (!_footV) {
        _footV = [[YOrderEvaluteFootView alloc]initWithFrame:CGRectMake(0, CGRectYH(_putV)+16, __kWidth, 50)];
        _footV.delegate = self;
    }
    return _footV;
}

#pragma mark ==YOrderEvaluteFootViewDelegate==
-(void)chooseStar:(NSInteger)star{
    [self.delegate giveStar:star index:self.tag];
}


#pragma mark ==YPutPictureViewDelegate==
-(void)addPhoto{
    [self.delegate addPhotos:self.tag];
}

#pragma mark ==UITextViewDelegate==
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _warnLb.hidden = YES;
    }else{
        _warnLb.hidden = NO;
    }

}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.delegate evaluteText:textView.text index:self.tag];
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

-(void)setModel:(YOrderEvalueModel *)model{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]]];
    _putV.imageArr = model.imageArr;
}


@end
