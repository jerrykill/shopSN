//
//  YPersonMoreCell.m
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonMoreCell.h"

@interface YPersonMoreCell()



@end

@implementation YPersonMoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


- (void)initView{
    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 25, 25)];
    [self addSubview:_headIV];
  

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+10, 18, 100, 15)];
    [self addSubview:_titleLb];
    _titleLb.textColor = [UIColor blackColor];
    _titleLb.font = MFont(15);
    _titleLb.textAlignment = NSTextAlignmentLeft;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}



@end
