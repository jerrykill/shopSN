//
//  YBillTypeCell.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBillTypeCell.h"
#import "YBillChooseView.h"

@interface YBillTypeCell ()

@property (strong,nonatomic) NSMutableArray *chooseArr;

@property (strong,nonatomic)  UILabel *headLb;

@end

@implementation YBillTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = __BackColor;
        _chooseArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    _headLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, 80, 15)];
    [self addSubview:_headLb];
    _headLb.textAlignment = NSTextAlignmentLeft;
    _headLb.textColor =LH_RGBCOLOR(102, 102, 102);
    _headLb.font = MFont(14);

}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(0, 35, __kWidth, 45*_dataArr.count/2)];
    [self addSubview:mainV];
    mainV.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<_dataArr.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseType:)];
        YBillChooseView *chooseV = [[YBillChooseView alloc]initWithFrame:CGRectMake(i%2*__kWidth/2+15, i/2*45, __kWidth/2, 45)];
        [mainV addSubview:chooseV];
        chooseV.title =_dataArr[i];
        chooseV.tag =i;
        [_chooseArr addObject:chooseV];
        [chooseV addGestureRecognizer:tap];
    }
}

-(void)setHead:(NSString *)head{
    _headLb.text = head;
}

-(void)chooseType:(UITapGestureRecognizer*)sender{
    for (YBillChooseView *chooseV in _chooseArr) {
        if (chooseV.tag==sender.view.tag) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
            [self.delegate chooseType:chooseV.title index:self.tag];
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}

-(void)setChoose:(NSString *)choose{
    for (YBillChooseView *chooseV in _chooseArr) {
        if ([choose isEqualToString:chooseV.title]) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}

@end
