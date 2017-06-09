//
//  YApplyDetailCell.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyDetailCell.h"

@interface YApplyDetailCell()

@property (strong,nonatomic) UILabel *titleLabel;

@end

@implementation YApplyDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLabel];
    }
    return self;
}



#pragma mark ==懒加载==
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, __kWidth-20, 60)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = MFont(15);
        _titleLabel.numberOfLines =0;
        _titleLabel.textColor = LH_RGBCOLOR(120, 120, 120);
    }
    return _titleLabel;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    CGSize size = [YGetAttribute getSpaceHeight:_title size:CGSizeMake(__kWidth-20, MAXFLOAT) rowHeight:4 font:MFont(15)];
    _titleLabel.frame = CGRectMake(10, 5, __kWidth-20, size.height);
    _titleLabel.attributedText =[YGetAttribute getSpaceString:_title size:CGSizeMake(__kWidth-20, MAXFLOAT) rowHeight:4 font:MFont(15)];
}

@end
