//
//  YClassCell.m
//  shopsN
//
//  Created by imac on 2016/11/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClassCell.h"

@interface YClassCell()



@end

@implementation YClassCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(1, (__kWidth*100/750-15)/2, __kWidth*180/750-1, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.font = MFont(13);
    _titleLb.textColor = [UIColor blackColor];


    _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, __kWidth*100/750)];
    [self addSubview:_lineIV];
    _lineIV.backgroundColor = [UIColor clearColor];

    UIImageView *booIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, __kWidth*100/750-1, __kWidth*180/750, 1)];
    [self addSubview:booIV];
    booIV.backgroundColor = LH_RGBCOLOR(230, 230, 230);
}




@end
