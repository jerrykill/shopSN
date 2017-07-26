//
//  YOrdersDetailCountCell.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailCountCell.h"

@interface YOrdersDetailCountCell ()

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UIImageView *moreIV;

@end

@implementation YOrdersDetailCountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.countLb];
    [self addSubview:self.moreIV];
}

#pragma mark ==懒加载==
-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-110)/2, 13, 80, 15)];
        _countLb.textAlignment = NSTextAlignmentRight;
        _countLb.textColor = __TextColor;
        _countLb.font = MFont(14);
    }
    return _countLb;
}

-(UIImageView *)moreIV{
    if (!_moreIV) {
        _moreIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_countLb)+13, 15, 18, 11)];
        _moreIV.image = MImage(@"under_arrow");
    }
    return _moreIV;
}

-(void)setCount:(NSString *)count{
    _count = count;
    _countLb.text = [NSString stringWithFormat:@"还有%@件",_count];
}

-(void)setShow:(BOOL)show{
    if (show) {
        _countLb.text = @"收起";
        _moreIV.hidden = YES;
    }else{
        _moreIV.hidden = NO;
        _countLb.text = [NSString stringWithFormat:@"还有%@件",_count];
       _moreIV.image = MImage(@"under_arrow");
    }
}

@end
