//
//  YPayAndSendChooseCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayAndSendChooseCell.h"
#import "YPayAndSendView.h"

@interface YPayAndSendChooseCell ()

@property (strong,nonatomic) NSMutableArray *chooseArr;

@property (strong,nonatomic) YPayAndSendView *firstV;

@property (strong,nonatomic)  YPayAndSendView *secondV;

@end

@implementation YPayAndSendChooseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _chooseArr = [NSMutableArray array];
    }
    return self;
}

-(void)setChooseList:(NSMutableArray<YServiceTitleModel *> *)chooseList{
    _chooseList = chooseList;
    for (int i=0; i<_chooseList.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)];
        YPayAndSendView *chooseV = [[YPayAndSendView alloc]initWithFrame:CGRectMake(0, 45*i, __kWidth, 45)];
        [self addSubview:chooseV];
        YServiceTitleModel *model = _chooseList[i];
        chooseV.title = model.titleName;
        chooseV.tag = 201+i;
        if (!i) {
            chooseV.userInteractionEnabled = NO;
            chooseV.choose = YES;
        }else{
            chooseV.userInteractionEnabled = YES;
            chooseV.choose = NO;
        }
        [chooseV addGestureRecognizer:tap];
        [_chooseArr addObject:chooseV];
    }
}

-(void)choose:(UITapGestureRecognizer*)tap{
    for (YPayAndSendView *chooseV in _chooseArr) {
        if (chooseV.tag == tap.view.tag) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
            [self.delegate chooseType:chooseV.title index:chooseV.tag-201];
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}


-(void)setChoose:(NSUInteger)choose{
    for (YPayAndSendView *chooseV in _chooseArr) {
        if (chooseV.tag == choose) {
            chooseV.choose = YES;
            chooseV.userInteractionEnabled = NO;
            [self.delegate chooseType:chooseV.title index:chooseV.tag-201];
        }else{
            chooseV.choose = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}

@end
