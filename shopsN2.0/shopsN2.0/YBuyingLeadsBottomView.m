//
//  YBuyingLeadsBottomView.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingLeadsBottomView.h"

@interface YBuyingLeadsBottomView()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YBuyingLeadsBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 17, __kWidth, 16)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = MFont(16);
    }
    return _titleLb;
}

-(void)setTitle:(NSString *)title{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总预算：%@元",title]];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(0, 4)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(4, attr.length-4)];
    _titleLb.attributedText = attr;
}

@end
