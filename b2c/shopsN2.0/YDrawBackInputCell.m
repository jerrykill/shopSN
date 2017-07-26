
//
//  YDrawBackInputCell.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YDrawBackInputCell.h"
#import "YPicPutView.h"

@interface YDrawBackInputCell ()<UITextViewDelegate,YPicPutViewDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITextView *detailTV;

@property (strong,nonatomic) UILabel *plachorLb;

@property (strong,nonatomic) YPicPutView *picPutV;


@property (assign,nonatomic) BOOL isEdit;

@end

@implementation YDrawBackInputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _isEdit=NO;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailTV];
    [_detailTV addSubview:self.plachorLb];
    [self addSubview:self.picPutV];

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectYH(_picPutV), __kWidth, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;

}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 100, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
        _titleLb.text = @"退货说明";
    }
    return _titleLb;
}

-(UITextView *)detailTV{
    if (!_detailTV) {
        _detailTV = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+8, __kWidth-20, 62)];
        _detailTV.layer.cornerRadius = 4;
        _detailTV.layer.borderColor = __BackColor.CGColor;
        _detailTV.layer.borderWidth = 1;
        _detailTV.textAlignment = NSTextAlignmentLeft;
        _detailTV.font = MFont(13);
        _detailTV.delegate = self;
    }
    return _detailTV;
}

-(UILabel *)plachorLb{
    if (!_plachorLb) {
        _plachorLb = [[UILabel alloc]initWithFrame:CGRectMake(11, 7, 200, 15)];
        _plachorLb.textAlignment = NSTextAlignmentLeft;
        _plachorLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _plachorLb.font = MFont(12);
        _plachorLb.text = @"请在此描述详细问题";
    }
    return _plachorLb;
}

-(YPicPutView *)picPutV{
    if (!_picPutV) {
        _picPutV = [[YPicPutView alloc]initWithFrame:CGRectMake(0, CGRectYH(_detailTV), __kWidth, 122)];
        _picPutV.delegate = self;
    }
    return _picPutV;
}

#pragma mark ==UITextViewDelegate==
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _isEdit= YES;
    return YES;
}

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
         [self.delegate getInputText:textView.text];
    }
    if (textView.text.length>0) {
        _plachorLb.hidden = YES;
    }else{
        _plachorLb.hidden = NO;
    }
    _isEdit = NO;
    return YES;
}


#pragma mark ==YDrawBackInputCellDelegate==
-(void)deleteImgIndex:(NSInteger)index{
    [self.delegate  deletePicIndex:index];
}

-(void)addPhoto{
    [self.delegate addPhotos];
}


-(void)setImageArr:(NSMutableArray *)imageArr{
    _picPutV.imageArr = imageArr;
}


@end
