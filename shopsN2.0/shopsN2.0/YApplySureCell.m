//
//  YApplySureCell.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplySureCell.h"

@implementation YApplySureCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, __kWidth-20, 20)];
    [self addSubview:titleLb];
    titleLb.font = MFont(15);
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.textColor = LH_RGBCOLOR(120, 120, 120);
    titleLb.text = @"填写《客户账期支付申请表》，确认后提交。";

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(titleLb)+15, __kWidth-20, 44)];
    [self addSubview:sureBtn];
    sureBtn.backgroundColor =__DefaultColor;
    sureBtn.titleLabel.font = MFont(18);
    sureBtn.layer.cornerRadius =5;
    [sureBtn setTitle:@"马上填表申请" forState:BtnNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [sureBtn addTarget:self action:@selector(choosePush) forControlEvents:BtnTouchUpInside];

}

- (void)choosePush{
    [self.delegate chooseApply];
}


@end
