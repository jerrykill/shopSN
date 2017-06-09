//
//  YCashedListView.m
//  shopsN
//
//  Created by imac on 2017/1/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCashedListView.h"
#import "YCashedNameCell.h"

@interface YCashedListView ()<UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) UIView *backV;

@end

@implementation YCashedListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-61)];
    [self addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];
    _backV.layer.cornerRadius = 10;

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, __kWidth-60, 20)];
    [_backV addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = __DTextColor;
    titleLb.font = MFont(19);
    titleLb.text = @"已兑换名单";

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 40, __kWidth-20, __kHeight-205)];
    [_backV addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UIButton *knowBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectYH(_tableView), __kWidth-60, 30)];
    [_backV addSubview:knowBtn];
    knowBtn.layer.cornerRadius = 10;
    knowBtn.backgroundColor = LH_RGBCOLOR(153, 153, 153);
    knowBtn.layer.borderColor = __BackColor.CGColor;
    knowBtn.layer.borderWidth = 1;
    knowBtn.titleLabel.font = MFont(18);
    [knowBtn setTitle:@"我知道了" forState:BtnNormal];
    [knowBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [knowBtn addTarget:self action:@selector(chooseKnow) forControlEvents:BtnTouchUpInside];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArr.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YCashedNameCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"YCashedNameCell"];
    if (!cell) {
        cell = [[YCashedNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCashedNameCell"];
    }
    cell.num = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.name = _nameArr[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(void)setNameArr:(NSArray *)nameArr{
    _nameArr = nameArr;
    [_tableView reloadData];
}

-(void)chooseKnow{
    [self removeFromSuperview];
}

@end
