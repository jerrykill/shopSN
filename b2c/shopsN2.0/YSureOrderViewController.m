//
//  YSureOrderViewController.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderViewController.h"
#import "YSureOrderAddressCell.h"
#import "YSureOrderPicNumCell.h"
#import "YSureOrderPayAndSendCell.h"
#import "YSureOrderDiscountCell.h"
#import "YSureOrderDateCell.h"
#import "YSureOrderWarnCell.h"
#import "YOrdersDetailMessageCell.h"
#import "YSureOrderWarnBottomView.h"
#import "YOrdersDetailMoneyCell.h"
#import "YSureOrderBottomView.h"
#import "YBuyingDatePicker.h"

#import "YAddressMangerViewController.h"
#import "YOrderGoodListViewController.h"
#import "YOrderChangePayAndSendViewController.h"
#import "YSureOrderCouponViewController.h"
#import "YSendTimeCheckView.h"
#import "YBillInfoViewController.h"
#import "YPayViewController.h"
#import "ChatViewController.h"


@interface YSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource,YSureOrderBottomViewDelegate,YSendTimeCheckViewDelegate,YBillInfoViewControllerDelegate,YBuyingDatePickerDelegate,YOrdersDetailMessageCellDelegate,YOrderGoodListViewControllerDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YSureOrderBottomView *bottomV;

@property (strong,nonatomic) YBuyingDatePicker *datePickV;

@property (strong,nonatomic) NSArray *psArr;

@property (strong,nonatomic) NSString *cupon;//优惠

@property (strong,nonatomic) NSString *cuponValue;

@property (strong,nonatomic) NSString *cuponId;//优惠券id

@property (strong,nonatomic) YSendTimeCheckView *dataCheckV;

@property (strong,nonatomic) NSString *chooseDay;

@property (strong,nonatomic) YOrderBillModel *bill;

@property (strong,nonatomic) NSString *message;//留言

@end

@implementation YSureOrderViewController

- (void)getBillInfo {
    _bill = [[YOrderBillModel alloc]init];
    [JKHttpRequestService POST:@"Order/invoice" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            NSDictionary *dic = data[0];
            _bill.type = dic[@"invoice_type"];
            _bill.info = dic[@"content"];
            _bill.headType= dic[@"invoice_title"];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}

-(void)getdata{
    _psArr = [NSArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddressData:) name:YSAddressChoose object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOrderGoods:) name:YSOrdersGoodChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPayAndSend:) name:YSPayAndSendChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCupon:) name:YSCuponChoose object:nil];

}

#pragma mark *** 从地址返回通知 ***
-(void)getAddressData:(NSNotification *)info{
    NSArray *arr = info.object;
    _address = arr[0];
    [_tableV reloadData];
    [self changeFreight];
}
#pragma mark ==修改商品清单==
-(void)getOrderGoods:(NSNotification*)info{
    _datas  = info.object;
    __block CGFloat totals = 0.00;
    [_datas enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totals+=[obj.goodMoney floatValue]*[obj.goodCount integerValue];
    }];
    _totalPay = [NSString stringWithFormat:@"%.2f",totals];
    _bottomV.total = [NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]];
    [_tableV reloadData];
    [self changeFreight];
}

#pragma mark ==修改配送和支付==
-(void)getPayAndSend:(NSNotification*)info{
    NSArray *dataArr = info.object;
    _psArr = dataArr;
    [_tableV reloadData];
    [self changeFreight];
}
#pragma mark ==选择优惠券==
-(void)getCupon:(NSNotification *)info{
    NSArray *data =info.object;
    YScouponModel *model = data.firstObject;
    _cuponId = model.ticketId;
    _cuponValue = model.value;
    _cupon = [NSString stringWithFormat:@"满%ld减%@元",[model.condition integerValue],model.value];
    _bottomV.total = [NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]-_cuponValue.floatValue];
    [_tableV reloadData];

}


#pragma mark - ==== 页面设置 =====
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    _cuponId = @"";
    [self.rightBtn setImage:MImage(@"head_service") forState:BtnNormal];
    [self getdata];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self getBillInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });

}

- (void)chooseRight{
    NSLog(@"联系客服");
    ChatViewController *vc = [[ChatViewController alloc]initWithConversationChatter:HXchatter conversationType:eConversationTypeChat];
    YNavigationController *navi = [[YNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navi animated:NO completion:nil];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

    _bottomV = [[YSureOrderBottomView alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 50)];
    [self.view addSubview:_bottomV];
    _bottomV.delegate = self;
    _bottomV.total = [NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]];

}
#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 8;
    }else{
        return 5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                YSureOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSureOrderAddressCell"];
                if (!cell) {
                    cell = [[YSureOrderAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSureOrderAddressCell"];
                }
                cell.model =_address;
                cells = cell;
            }
                break;
            case 1:
            {
                YSureOrderPicNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSureOrderPicNumCell"];
                if (!cell) {
                    cell = [[YSureOrderPicNumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSureOrderPicNumCell"];
                }
                cell.data = _datas;
                cells =cell;
            }
                break;
            case 2:
            {
                YSureOrderPayAndSendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSureOrderPayAndSendCell"];
                if (!cell) {
                    cell = [[YSureOrderPayAndSendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSureOrderPayAndSendCell"];
                }
                if (_psArr.count) {
                    YServiceTitleModel *model =_psArr[1];
                    cell.payType = @"在线支付";
                    cell.sendType = model.titleName;
                }else{
                  cell.payType = @"在线支付";
                  cell.sendType = [NSString stringWithFormat:@"%@物流",ShortTitle];
                }
                cells= cell;
            }
                break;
            case 3:
            case 5:
            {
                YSureOrderDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSureOrderDiscountCell"];
                if (!cell) {
                    cell = [[YSureOrderDiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSureOrderDiscountCell"];
                }
                if (indexPath.row==3) {
                    cell.title = @"选择优惠券";
                    if (IsNilString(_cupon)) {
                         cell.detail = @"选择优惠券";
                    }else{
                        cell.detail = _cupon;
                    }
                }else{
                    cell.title = @"开具发票";
                    if (IsNilString(_bill.type)) {
                        cell.detail = @"无需发票";
                    }else{
                        cell.detail = _bill.type;
                    }
                }
                cells = cell;
            }
                break;
            case 4:
            {
                YSureOrderDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSureOrderDateCell"];
                if (!cell) {
                    cell = [[YSureOrderDateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSureOrderDateCell"];
                }
                if (IsNilString(_chooseDay)) {
                    cell.date = @"默认时间";
                }else{
                    cell.date = _chooseDay;
                }
                cells = cell;
            }
                break;
            case 6:
            {
                YSureOrderWarnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSureOrderWarnCell"];
                if (!cell) {
                    cell = [[YSureOrderWarnCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSureOrderWarnCell"];
                }
                cell.title = @"此商品为定制，不支持7天无理由退货";
                cells = cell;
            }
                break;
            case 7:
            {
                YOrdersDetailMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailMessageCell"];
                if (!cell) {
                    cell = [[YOrdersDetailMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailMessageCell"];
                }
                cell.title = @"给商家留言：";
                cell.warn = @"选填：备注限制在45个字以内";
                cell.delegate = self;
                cells = cell;
            }
                break;
            default:
                break;
        }
    }else{
        YOrdersDetailMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailMoneyCell"];
        if (!cell) {
            cell = [[YOrdersDetailMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailMoneyCell"];
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.titleLb.text = @"商品金额";
                cell.detailLb.text = [NSString stringWithFormat:@"¥%.2f",[_totalPay floatValue]];
            }
                break;
            case 1:
            {
                cell.titleLb.text = @"优惠";
                NSString *money= @"0.00";
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"-   ¥%@",money]];
                [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(0, 1)];
                [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(117, 117, 117) range:NSMakeRange(1, attr.length-1)];
                cell.detailLb.attributedText = attr;
            }
                break;
            case 2:
            {
                cell.titleLb.text = @"运费";
                if (IsNilString(_freight)) {
                    cell.detailLb.text = @"0.00";
                }else{
                    cell.detailLb.text = [NSString stringWithFormat:@"%.2f",[_freight floatValue]];
                }

                cell.detailLb.textColor = LH_RGBCOLOR(117, 117, 117);
            }
                break;
            case 3:
            {
                cell.titleLb.text = @"优惠券";
                NSString *money =@"0.00";
                if (!IsNilString(_cuponValue)) {
                    money = [NSString stringWithFormat:@"%.2f",_cuponValue.floatValue];
                }
                cell.detailLb.text = [NSString stringWithFormat:@"- ¥%@",money];
                cell.detailLb.textColor = __DefaultColor;
            }
                break;
            case 4:
            {
                cell.titleLb.text = @"当前积分";
                cell.detailLb.text = [NSString stringWithFormat:@"%@",_personIntegral];
                cell.detailLb.textColor = LH_RGBCOLOR(255, 114, 0);
            }
                break;
            default:
                break;
        }
        cells = cell;
    }
    return cells;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        YSureOrderWarnBottomView *header = [[YSureOrderWarnBottomView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 45)];
        header.title = @"温馨提示：支付完毕后及时联系在线客服";
        return header;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 85;
        }else if (indexPath.row==1){
            return 95;
        }else if (indexPath.row==2){
            return 70;
        }else if (indexPath.row==7){
            return 101;
        }else{
            return 56;
        }
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 45;
    }else{
        return 0;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NSLog(@"选择地址");
            YAddressMangerViewController *vc = [[YAddressMangerViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            NSLog(@"查看清单");
            YOrderGoodListViewController *vc = [[YOrderGoodListViewController alloc]init];
            vc.delegate = self;
            vc.datas = _datas;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            NSLog(@"选择支付和配送");
            YOrderChangePayAndSendViewController *vc = [[YOrderChangePayAndSendViewController alloc]init];
            if (_psArr.count>0) {
                YServiceTitleModel *model =_psArr[1];
                vc.sendType = model.titleName;
                vc.payType = @"在线支付";
            }
            vc.addressId = _address.addressId;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            NSLog(@"选择优惠券");
            YSureOrderCouponViewController *vc = [[YSureOrderCouponViewController alloc]init];
            vc.totalPay = _totalPay;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==4){
            NSLog(@"选择送货时间");
            [self.view addSubview:self.datePickV];
        }else if (indexPath.row==5){
            NSLog(@"选择发票");
            YBillInfoViewController *vc = [[YBillInfoViewController alloc]init];
            vc.delegate = self;
            vc.billModel =_bill;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


#pragma mark ==懒加载==
-(YBuyingDatePicker *)datePickV{
    if (!_datePickV) {
        _datePickV = [[YBuyingDatePicker alloc]initWithFrame:CGRectMake(0, __kHeight-260, __kWidth, 260)];
        _datePickV.delegate = self;
    }
    return _datePickV;
}
#pragma mark ==YOrderGoodListViewControllerDelegate==
-(void)orderListFreight:(NSString *)freight{
//    _freight = [NSString stringWithFormat:@"%.2f",[_freight floatValue]+[freight floatValue]];
//    [_tableV reloadData];
    [self changeFreight];
}


#pragma mark ==YBuyingDatePickerDelegate==
-(void)chooseDateTime:(NSString *)sender{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *coms = [NSDate dateWithTimeIntervalSince1970:[sender integerValue]];
    NSString *dates =[formatter stringFromDate:coms];
    _chooseDay = dates;
    [_tableV reloadData];
}

- (void)hiddenView{
    _tableV.transform =CGAffineTransformIdentity;
}
#pragma mark ==YBillInfoViewControllerDelegate==
-(void)getInfo:(YOrderBillModel *)data{
    _bill = data;
    [_tableV reloadData];
}
#pragma mark ==YOrdersDetailMessageCellDelegate==
-(void)ordesDetailMessage:(NSString *)sender{
    _message = sender;
    NSLog(@"%@",_message);
}


#pragma mark ==YSureOrderBottomViewDelegate==
-(void)putOrder{
    NSLog(@"支付");
    //支付配送
    NSString *payType= @"1";
    NSString *shipType = @"";
    if (_psArr.count) {
        YServiceTitleModel *model = _psArr[1];
        shipType = model.titleName;
    }

    //商品
    NSMutableArray *goods = [NSMutableArray array];
    for (YShopGoodModel *model in _datas) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.goodId forKey:@"id"];
        [dic setValue:model.goodCount forKey:@"num"];
        [dic setValue:model.goodMoney forKey:@"goods_price"];
        [goods addObject:dic];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    NSDictionary *params = [[NSDictionary alloc]init];
    if (IsNilString(_message)) {
        _message = @"";
    }
    NSString *isBill=@"1";
    if (IsNilString(_bill.type)) {
        isBill = @"0";
        params = @{@"goods":jsonStr,@"buyType":_buyType,@"price_sum":[NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]-[_cuponValue integerValue]],@"address_id":_address.addressId,@"remarks":_message,@"translate":isBill,@"shipping_monery":_freight,@"app_user_id":[UdStorage getObjectforKey:Userid],@"pay_type":payType,@"shipping":shipType,@"coupon_id":_cuponId};
    }else{
        NSMutableArray *bills = [NSMutableArray array];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        if (_bill.header.length) {
            dic[@"invoice_title"] = [NSString stringWithFormat:@"%@(%@)",_bill.headType,_bill.header];
        }else{
            dic[@"invoice_title"] = _bill.headType;
        }
        dic[@"invoice_type"] = _bill.type;
        dic[@"content"] = _bill.info;
        [bills addObject:dic];
        NSData *billData = [NSJSONSerialization dataWithJSONObject:bills options:NSJSONWritingPrettyPrinted error:nil];
        NSString *billJson = [[NSString alloc]initWithData:billData encoding:NSUTF8StringEncoding];
        params = @{@"goods":jsonStr,@"buyType":_buyType,@"price_sum":[NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]-[_cuponValue integerValue]],@"address_id":_address.addressId,@"remarks":_message,@"translate":isBill,@"shipping_monery":_freight,@"app_user_id":[UdStorage getObjectforKey:Userid],@"invoice":billJson,@"pay_type":payType,@"shipping":shipType,@"coupon_id":_cuponId};
    }
    [JKHttpRequestService POST:@"Order/orderBegin" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSString *data = jsonDic[@"data"];
             [[NSNotificationCenter defaultCenter] postNotificationName:YSGoodAddtoShopCart object:nil userInfo:nil];
            YShopGoodModel *model = _datas.firstObject;
            NSString *orderName = model.goodTitle;
            NSString *pay = [NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]-[_cuponValue integerValue]];
            YPayViewController *vc = [[YPayViewController alloc]init];
            vc.orderId = data;
            vc.orderName = orderName;
            vc.payMoney = pay;
            vc.addressModel = _address;
            [self.navigationController  pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];


}

#pragma mark ==运费变动==
- (void)changeFreight {
    NSString *shipType = @"";
    if (_psArr.count) {
        if ([_psArr[1] isKindOfClass:[NSString class]]) {
            shipType = @"";
        }else{
            YServiceTitleModel *model = _psArr[1];
            shipType = model.titleId;
        }
    }

    NSString *address = _address.addressId;
    NSMutableArray *goods = [NSMutableArray array];
    for (YShopGoodModel *model in _datas) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.goodId forKey:@"id"];
        [dic setValue:model.goodCount forKey:@"num"];
        [goods addObject:dic];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    [JKHttpRequestService POST:@"order/freight" withParameters:@{@"id":shipType,@"address_id":address,@"goods":jsonStr,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data =jsonDic[@"data"];
            _freight =data[@"freight"];
            [_tableV reloadData];
            _bottomV.total = [NSString stringWithFormat:@"%.2f",[_totalPay floatValue]+[_freight floatValue]-_cuponValue.floatValue];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}


//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *tableview = (UITableView *)scrollView;
    [self checkView:tableview];
}


#pragma mark ==实现滑动禁止==
- (void)checkView:(UITableView*)tableview {
    CGFloat sectionHeaderHeight = 40;
    CGFloat sectionFooterHeight = 45;
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
