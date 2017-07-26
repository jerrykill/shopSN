//
//  YReturnsNumCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YReturnsNumCell.h"
#import "YChnageCountBtn.h"

@interface YReturnsNumCell()<YChnageCountBtnDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) YChnageCountBtn *changeNumV;

@property (strong,nonatomic) UILabel *warnLb;

@property (strong,nonatomic) UIView *bottomV;

@end

@implementation YReturnsNumCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.changeNumV];
    [self addSubview:self.warnLb];
    [self addSubview:self.bottomV];

}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, __kWidth-20, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(15);
        _titleLb.textColor = __DTextColor;
        _titleLb.text = @"申请数量";
    }
    return _titleLb;
}

-(YChnageCountBtn *)changeNumV{
    if (!_changeNumV) {
        _changeNumV = [[YChnageCountBtn alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+15, 120, 40)];
        _changeNumV.delegate = self;
        _changeNumV.count =@"1";
    }
    return _changeNumV;
}

-(UILabel *)warnLb{
    if (!_warnLb) {
        _warnLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_changeNumV), __kWidth-20, 15)];
        _warnLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _warnLb.textAlignment = NSTextAlignmentLeft;
        _warnLb.font = MFont(13);
    }
    return _warnLb;
}

-(UIView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 125, __kWidth, 10)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

#pragma mark ==YChnageCountBtnDelegate==
-(void)changeCount:(BOOL)sender{
    [self.delegate changeApplyNum:sender];
}
-(void)setCount:(NSString *)count{
    _warnLb.text =[NSString stringWithFormat:@"您最多提交的数量为%@个",count];
}

@end
