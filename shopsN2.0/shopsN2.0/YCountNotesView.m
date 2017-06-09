//
//  YCountNotesView.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCountNotesView.h"

@interface YCountNotesView ()

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YCountNotesView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.countLb];
    [self addSubview:self.detailLb];

}

#pragma mark ==懒加载==
-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 20, 15)];
        _countLb.textAlignment = NSTextAlignmentLeft;
        _countLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _countLb.font = MFont(13);
    }
    return _countLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_countLb), 5, __kWidth-40, 15)];
        _detailLb.textAlignment= NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _detailLb.font = MFont(13);
        _detailLb.numberOfLines = 0;
    }
    return _detailLb;
}



-(void)setCount:(NSString *)count{
    _countLb.text = [NSString stringWithFormat:@"%@.",count];
}

-(void)setDetail:(NSString *)detail{
    _detail = detail;
     CGSize size =[_detail boundingRectWithSize:CGSizeMake(__kWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
    _detailLb.frame = CGRectMake(CGRectXW(_countLb), 5, __kWidth-40, size.height);
    _detailLb.text = _detail;
}

@end
