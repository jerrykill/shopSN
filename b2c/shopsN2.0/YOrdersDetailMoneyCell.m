//
//  YOrdersDetailMoneyCell.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailMoneyCell.h"

@interface YOrdersDetailMoneyCell()



@end

@implementation YOrdersDetailMoneyCell

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
    [self addSubview:self.detailLb];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, 60, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(119, 119, 119);
        _titleLb.font = MFont(13);
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-120, 14, 110, 15)];
        _detailLb.textAlignment = NSTextAlignmentRight;
        _detailLb.font = MFont(14);
        _detailLb.textColor = __DefaultColor;
    }
    return _detailLb;
}

@end
