//
//  YChooseSalesServiceCell.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YChooseSalesServiceCell.h"
#import "YServiceTypeBtn.h"

@interface YChooseSalesServiceCell()

@property (strong,nonatomic) NSMutableArray *btnArr;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YChooseSalesServiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _btnArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, __kWidth-20, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment= NSTextAlignmentLeft;
    _titleLb.font = MFont(15);
    _titleLb.textColor = __DTextColor;
    _titleLb.text = @"服务类型";

    NSArray *titleArr = @[@"退货",@"换货",@"维修"];
    for (int i=0; i<3; i++) {
        YServiceTypeBtn *btn = [[YServiceTypeBtn alloc]initWithFrame:CGRectMake(10+i*((__kWidth-40)/3+10), CGRectYH(_titleLb)+15, (__kWidth-40)/3, 44)];
        [self addSubview:btn];
        btn.tag = i;
        btn.lineIV.hidden =YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = __DTextColor.CGColor;
        btn.titleLabel.font = MFont(15);
        [btn setTitle:titleArr[i] forState:BtnNormal];
        [btn setTitleColor:__DTextColor forState:BtnNormal];
        [btn setTitle:titleArr[i] forState:BtnStateSelected];
        [btn setTitleColor:__DefaultColor forState:BtnStateSelected];
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:BtnTouchUpInside];
        [_btnArr addObject:btn];
    }

}

-(void)chooseType:(YServiceTypeBtn*)sender{
    for (YServiceTypeBtn *btn in _btnArr) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
            btn.lineIV.hidden =NO;
            btn.userInteractionEnabled = NO;
            btn.layer.borderColor = __DefaultColor.CGColor;
        }else{
            btn.selected = NO;
            btn.userInteractionEnabled =YES;
            btn.lineIV.hidden =YES;
            btn.layer.borderColor = __DTextColor.CGColor;
        }
    }
    [self.delegate chooseServiceType:(sender.tag)];
}



@end
