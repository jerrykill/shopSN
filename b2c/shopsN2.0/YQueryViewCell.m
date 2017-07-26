//
//  YQueryViewCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YQueryViewCell.h"
#import "YProgressDetailCell.h"

@interface YQueryViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UITableView *tableV;

@end

@implementation YQueryViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}
-(void)initView{

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kWidth-40, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(15);
    _titleLb.text = @"审核进度";

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb)+14, __kWidth, 0)];
    [self addSubview:_tableV];
    _tableV.backgroundColor = [UIColor whiteColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.scrollEnabled = NO;
    
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YProgressDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YProgressDetailCell"];
    if (!cell) {
        cell = [[YProgressDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YProgressDetailCell"];
    }
    if (_dataArr.count) {
        YReturnsSpeedInfoModel *model =_dataArr[indexPath.row];
        cell.model = model;
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}


-(void)setDataArr:(NSMutableArray<YReturnsSpeedInfoModel *> *)dataArr{
    _dataArr =dataArr;
    _tableV.frame = CGRectMake(0, CGRectYH(_titleLb)+14, __kWidth, 85*_dataArr.count);
    [_tableV reloadData];
    
}


@end
