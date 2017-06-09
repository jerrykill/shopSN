//
//  YApplyStrengthsCell.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyStrengthsCell.h"



@implementation YApplyStrengthsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    NSArray *titleArr = @[@"无抵押\n零手续费",@"缓解资金\n周转压力",@"操作便捷\n提高采购\n效率"];
    for (int i=0; i<3; i++) {
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+((__kWidth-40)/3+10)*i, 0, (__kWidth-40)/3, (__kWidth-40)/3)];
        [self addSubview:titleBtn];
        titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        titleBtn.layer.cornerRadius = (__kWidth-40)/6;
        titleBtn.layer.borderColor = __DefaultColor.CGColor;
        titleBtn.layer.borderWidth = 1;
        titleBtn.titleLabel.numberOfLines = 0;
        titleBtn.titleLabel.font = MFont(18);
        [titleBtn setTitle:titleArr[i] forState:BtnNormal];
        [titleBtn setTitleColor:__DefaultColor forState:BtnNormal];
    }
}




@end
