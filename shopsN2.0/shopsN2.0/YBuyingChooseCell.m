//
//  YBuyingChooseCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingChooseCell.h"
#import "YBillChooseView.h"

@interface YBuyingChooseCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) NSMutableArray *chooseTypeArr;

@end

@implementation YBuyingChooseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _chooseTypeArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
     [self addSubview:self.titleLb];
}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb =[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setChooseArr:(NSArray *)chooseArr{
    _chooseArr = chooseArr;
    for (int i=0; i<_chooseArr.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseType:)];
        YBillChooseView *chooseV = [[YBillChooseView alloc]initWithFrame:CGRectMake(90+i*(__kWidth-90)/_chooseArr.count, 0, (__kWidth-90)/_chooseArr.count, 44)];
        [self addSubview:chooseV];
        chooseV.title =_chooseArr[i];
        chooseV.tag =i;
        [_chooseTypeArr addObject:chooseV];
        [chooseV addGestureRecognizer:tap];
    }
    
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)chooseType:(UITapGestureRecognizer*)sender{
    for (YBillChooseView *chooseV in _chooseTypeArr) {
        if (chooseV.tag==sender.view.tag) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
            [self.delegate chooseType:chooseV.title index:(self.tag-200)];
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}

-(void)setChoose:(NSString *)choose{
    for (YBillChooseView *chooseV in _chooseTypeArr) {
        if ([chooseV.title isEqualToString:choose]) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}

@end
