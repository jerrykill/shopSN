
//
//  YCustomPurchaseMoneyCell.m
//  shopsN
//
//  Created by imac on 2017/3/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCustomPurchaseMoneyCell.h"
#import "YBillChooseView.h"

@interface YCustomPurchaseMoneyCell()

@property (strong,nonatomic) NSMutableArray *chooseArr;

@property (strong,nonatomic) UILabel *headLabel;

@end

@implementation YCustomPurchaseMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.headLabel];
        _chooseArr= [NSMutableArray array];
        self.userInteractionEnabled = YES;
    }
    return self;
}


#pragma mark ==懒加载==
- (UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, __kWidth-20, 20)];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.font = MFont(15);
        _headLabel.textColor = __DTextColor;
    }
    return _headLabel;
}

-(void)setTitle:(NSString *)title{
    _headLabel.text = title;
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[YBillChooseView class]]) {
            [obj removeFromSuperview];
        }
    }
    for (int i=0; i<_dataArr.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseType:)];
        YBillChooseView *chooseV = [[YBillChooseView alloc]initWithFrame:CGRectMake(i%2*__kWidth/2+15, i/2*35+35, __kWidth/2, 35)];
        [self addSubview:chooseV];
        chooseV.title =_dataArr[i];
        chooseV.tag =i+1;
        [_chooseArr addObject:chooseV];
        [chooseV addGestureRecognizer:tap];
    }
}

-(void)chooseType:(UITapGestureRecognizer*)sender{
    for (YBillChooseView *chooseV in _chooseArr) {
        if (chooseV.tag==sender.view.tag) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
            [self.delegate chooseType:chooseV.title index:chooseV.tag];
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}



@end
