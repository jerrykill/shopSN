//
//  YPayCardAddCell.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayCardAddCell.h"

@implementation YPayCardAddCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIButton *mainBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, __kWidth-30, 40)];
    [self addSubview:mainBtn];
    mainBtn.titleLabel.font = MFont(20);
    [mainBtn setTitle:@"请添加银行卡" forState:BtnNormal];
    [mainBtn setTitleColor:LH_RGBCOLOR(151, 151, 151) forState:BtnNormal];
    [mainBtn addTarget:self action:@selector(AddCards) forControlEvents:BtnTouchUpInside];
}


-(void)AddCards{
    [self.delegate AddCard];
}

@end
