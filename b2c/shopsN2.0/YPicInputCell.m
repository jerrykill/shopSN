
//
//  YPicInputCell.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPicInputCell.h"

@interface YPicInputCell ()

@property (strong,nonatomic) UIButton *cancelBtn;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UIButton *addBtn;

@property (strong,nonatomic) UILabel *addLb;

@end

@implementation YPicInputCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    [self addSubview:self.goodIV];
    [_goodIV addSubview:self.cancelBtn];
    [_goodIV bringSubviewToFront:_cancelBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.addLb];
}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 76, 76)];
        _goodIV.userInteractionEnabled = YES;
    }
    return _goodIV;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(24, 24, 28, 28)];
        _cancelBtn.layer.cornerRadius = 14;
        _cancelBtn.userInteractionEnabled = YES;
        [_cancelBtn setImage:MImage(@"list_pic_close") forState:BtnNormal];
        [_cancelBtn addTarget:self action:@selector(chooseCancel) forControlEvents:BtnTouchUpInside];

    }
    return _cancelBtn;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(18+6, 14, 38, 38)];
        _addBtn.backgroundColor = [UIColor clearColor];
        [_addBtn setImage:MImage(@"list_pic_add") forState:BtnNormal];
        _addBtn.userInteractionEnabled =NO;
        _addBtn.hidden = YES;
    }
    return _addBtn;
}

-(UILabel *)addLb{
    if (!_addLb) {
        _addLb = [[UILabel alloc]initWithFrame:CGRectMake(6, 56, 76, 15)];
        _addLb.text = @"添加图片";
        _addLb.textAlignment = NSTextAlignmentCenter;
        _addLb.textColor = LH_RGBCOLOR(175, 175, 175);
        _addLb.font =MFont(13);
        _addLb.hidden = YES;
    }
    return _addLb;
}

-(void)chooseCancel{
    [self.delegate deletePic:self.tag];
}

-(void)setIsAdd:(BOOL)isAdd{
    if (isAdd) {
        _addBtn.hidden=NO;
        _addLb.hidden = NO;
        _goodIV.hidden =YES;
    }else{
        _addBtn.hidden=YES;
        _addLb.hidden = YES;
        _goodIV.hidden =NO;
    }

}

-(void)setImage:(UIImage *)image{
    _goodIV.image = image;
    _addBtn.hidden=YES;
    _addLb.hidden = YES;
    _goodIV.hidden =NO;
}

@end
