//
//  YReturnsOrderCell.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YReturnsOrderCell.h"
#import "YGoodReturnsCell.h"

@interface YReturnsOrderCell ()<UITableViewDelegate,UITableViewDataSource,YGoodReturnsCellDelegate>

@property (strong,nonatomic) UILabel *orderIdLb;

@property (strong,nonatomic) UILabel *dateLb;

@property (strong,nonatomic) UILabel *statusLb;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) UIView *bottomV;


@end

@implementation YReturnsOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.orderIdLb];
    [self addSubview:self.statusLb];
    [self addSubview:self.dateLb];
    [self addSubview:self.tableV];

}
#pragma mark ==懒加载==
-(UILabel *)orderIdLb{
    if (!_orderIdLb) {
        _orderIdLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kWidth-100, 15)];
        _orderIdLb.textAlignment = NSTextAlignmentLeft;
        _orderIdLb.textColor = __DTextColor;
        _orderIdLb.font = MFont(13);
    }
    return _orderIdLb;
}

-(UILabel *)statusLb{
    if (!_statusLb) {
        _statusLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-90, 20, 80, 15)];
        _statusLb.textAlignment = NSTextAlignmentRight;
        _statusLb.font = MFont(15);
        _statusLb.textColor = __DefaultColor;
    }
    return _statusLb;
}

-(UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_orderIdLb)+8, __kWidth-100, 15)];
        _dateLb.textAlignment = NSTextAlignmentLeft;
        _dateLb.font = MFont(13);
        _dateLb.textColor = __TextColor;
    }
    return _dateLb;
}

-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, __kWidth, 120)];
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.separatorColor = [UIColor clearColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.scrollEnabled = NO;
        _tableV.userInteractionEnabled = YES;
          _tableV.tableFooterView =self.bottomV;
    }
    return _tableV;
}

-(UIView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 10)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodReturnsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGoodReturnsCell"];
    if (!cell) {
        cell = [[YGoodReturnsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGoodReturnsCell"];
    }
    cell.model = _model.list[indexPath.row];
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark ==YGoodReturnsCellDelegate==
-(void)chooseAction:(NSInteger)index{
    [self.delegate chooseAction:index tag:self.tag];
}

-(void)setModel:(YReturnsOrdersModel *)model{
    _model =model;
    [_tableV reloadData];
    _tableV.frame = CGRectMake(0, 70, __kWidth, 110*_model.list.count+10);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (!IsNilString(_model.createDate)) {
        NSDate *times =[NSDate dateWithTimeIntervalSince1970:[model.createDate doubleValue]];
        _orderIdLb.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderId];
        _dateLb.text = [NSString stringWithFormat:@"下单时间：%@",[dateFormatter stringFromDate:times]];
    }else{
        NSDate *times =[NSDate dateWithTimeIntervalSince1970:[model.applyTime doubleValue]];

         _orderIdLb.text = [NSString stringWithFormat:@"服务单号：%@",_model.serviceId];
        _dateLb.text = [NSString stringWithFormat:@"申请时间：%@",[dateFormatter stringFromDate:times]];
    }
    switch ([_model.status integerValue]) {
        case 33:
            _statusLb.text = @"已完成";
            break;
        case 22:
            _statusLb.text = @"待评价";
            break;
        default:
            break;
    }
//    _statusLb.text = _model.status;

}



@end
