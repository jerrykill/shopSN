//
//  YOrdersDetailViewController.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailViewController.h"
#import "YOrderdetailHeadCell.h"
#import "YOrdersDetailAddressCell.h"
#import "YGroupDetailGoodCell.h"
#import "YOrdersDetailCountCell.h"
#import "YOrdersDetailCheckCell.h"
#import "YOrdersDetailMessageCell.h"
#import "YOrdersDetailMoneyCell.h"
#import "YOrdersDetailTimeCell.h"
#import "YAddressModel.h"
#import "YSOrderModel.h"

#import "YAddressMangerViewController.h"
#import "YOrdersDetailActionBottomView.h"
#import "YEvaluteOrderViewController.h"
#import "YSureOrderViewController.h"
#import "YPayViewController.h"
#import "YApplyDrawbackViewController.h"
#import "YLogisticsInfoViewController.h"
#import "YPayViewController.h"

@interface YOrdersDetailViewController ()<UITableViewDelegate,UITableViewDataSource,YOrdersDetailActionBottomViewDelegate,YGroupDetailGoodCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YAddressModel *addressModel;

@property (nonatomic) BOOL show;

@property (strong,nonatomic) YSOrderModel *orderModel;


@end

@implementation YOrdersDetailViewController



-(void)getData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Order/orderDetail" withParameters:@{@"order_id":_orderId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            strongSelf.dataArr = [YSParseTool getParseOrderDetailGoods:data[@"child"]];
            NSArray *address =@[data[@"address_id"]];
            strongSelf.addressModel = [YSParseTool getParseAddress:address].firstObject;
            strongSelf.orderModel = [YSParseTool getParseOrderDetails:data];
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self getData];
    [self initView];
}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-40)];
    [self.view addSubview:_tableV];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.backgroundColor = __BackColor;

    YOrdersDetailActionBottomView *bottomV = [[YOrdersDetailActionBottomView alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 40)];
    [self.view addSubview:bottomV];
    bottomV.delegate = self;
    bottomV.status = _status;
}

//返回
-(void)back{
    NSArray *list = self.navigationController.viewControllers;
    if ([list[list.count-2] isKindOfClass:[YPayViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        if (_show) {
            return _dataArr.count+1;
        }else{
            if (_dataArr.count>3) {
                return 4;
            }else{
                return _dataArr.count;
            }
        }
    }else if (section==2){
        return 4;
    }else if (section==3){
        return 5;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            YOrderdetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrderdetailHeadCell"];
            if (!cell) {
                cell = [[YOrderdetailHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrderdetailHeadCell"];
            }
            cell.orderNo = _orderModel.orderId;
            cell.status = _status;
            cells =cell;
        }else{
            YOrdersDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailAddressCell"];
            if (!cell) {
                cell = [[YOrdersDetailAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailAddressCell"];
            }
            cell.model =_addressModel;
            cells = cell;
        }
    }else if (indexPath.section==1){
        if (_dataArr.count<=3) {
            YGroupDetailGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGroupDetailGoodCell"];
            if (!cell) {
                cell = [[YGroupDetailGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGroupDetailGoodCell"];
            }
            YShopGoodModel *model = _dataArr[indexPath.row];
            cell.model = model;
            if ([_status isEqualToString:@"待评价"]) {
                cell.status = @"yes";
                cell.delegate = self;
            }
            cells =cell;
        }else{
          if (_show) {//展开
            if (indexPath.row==_dataArr.count) {
                YOrdersDetailCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailCountCell"];
                if (!cell) {
                    cell = [[YOrdersDetailCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailCountCell"];
                }
                cell.count = [NSString stringWithFormat:@"%ld",(_dataArr.count-3)];
                cell.show=_show;
                cells=cell;
            }else{
                YGroupDetailGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGroupDetailGoodCell"];
                if (!cell) {
                  cell = [[YGroupDetailGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGroupDetailGoodCell"];
                }
                YShopGoodModel *model = _dataArr[indexPath.row];
                cell.model = model;
                if ([_status isEqualToString:@"待评价"]) {
                    cell.status = @"yes";
                    cell.delegate = self;
                }
                cells =cell;
            }
          }else{//收起
            if (indexPath.row==3) {
                    YOrdersDetailCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailCountCell"];
                    if (!cell) {
                        cell = [[YOrdersDetailCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailCountCell"];
                    }
                    cell.count = [NSString stringWithFormat:@"%ld",(_dataArr.count-3)];
                    cell.show=_show;
                    cells=cell;
            }else{
                    YGroupDetailGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGroupDetailGoodCell"];
                    if (!cell) {
                        cell = [[YGroupDetailGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGroupDetailGoodCell"];
                    }
                    YShopGoodModel *model = _dataArr[indexPath.row];
                    cell.model = model;
                    if ([_status isEqualToString:@"待评价"]) {
                       cell.status = @"yes";
                       cell.delegate = self;
                    }
                    cells =cell;
                }
        }
        }
    }else if (indexPath.section==2){
        if (indexPath.row==3) {
            YOrdersDetailMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailMessageCell"];
            if (!cell) {
                cell = [[YOrdersDetailMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailMessageCell"];
            }
            cell.inputTV.userInteractionEnabled = NO;
            cells = cell;
        }else{
            YOrdersDetailCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailCheckCell"];
            if (!cell) {
                cell = [[YOrdersDetailCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailCheckCell"];
            }
            NSArray *titleArr = @[@"支付方式：",@"配送方式：",@"开具发票："];
            NSString *pay= @"在线支付";
            NSArray *detailArr = @[pay,@"默认物流",@"无需发票"];
            if (_orderModel) {
                detailArr = @[pay,_orderModel.sendType,_orderModel.invoice?:@"无需发票"];
            }
            cell.title = titleArr[indexPath.row];
            cell.detail = detailArr[indexPath.row];
            cells = cell;
        }
    }else if (indexPath.section==3){
        YOrdersDetailMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailMoneyCell"];
        if (!cell) {
            cell= [[YOrdersDetailMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailMoneyCell"];
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.titleLb.text = @"商品总额";
                cell.detailLb.textColor = __DefaultColor;
                __block CGFloat money=0.00;
                [_dataArr enumerateObjectsUsingBlock:^(YShopGoodModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    money+=[obj.goodMoney floatValue]*[obj.goodCount integerValue];
                }];
                cell.detailLb.text = [NSString stringWithFormat:@"%.2f",money];
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
                NSString *money= _orderModel.freight;
                cell.detailLb.textColor = LH_RGBCOLOR(117, 117, 117);
                cell.detailLb.text = [NSString stringWithFormat:@"¥%@",money];
            }
                break;
            case 3:
            {
                cell.titleLb.text = @"优惠券";
                if (!IsNilString(_orderModel.couponMoney)) {
                    cell.detailLb.text = [NSString stringWithFormat:@"- ¥%@",_orderModel.couponMoney];
                }else{
                    cell.detailLb.text = @"- ¥0.00";
                }
            }
                break;
            case 4:
            {
                cell.titleLb.text = @"实付款";
                cell.titleLb.textColor = __DTextColor;
                NSString *money= [NSString stringWithFormat:@"¥%@",_orderModel.payMoney];
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",money]];
                [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(0, attr.length)];
                [attr addAttribute:NSFontAttributeName value:MFont(12) range:NSMakeRange(0, 1)];
                [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(1, attr.length-1)];
                cell.detailLb.attributedText = attr;
            }
                break;
            default:
                break;
        }
        cells = cell;
    }else if (indexPath.section==4){
        YOrdersDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailTimeCell"];
        if (!cell) {
            cell = [[YOrdersDetailTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailTimeCell"];
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        cell.createTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_orderModel.createTime integerValue]]];
        if (!IsNilString(_orderModel.payTime)&&_orderModel.payTime.integerValue>0) {
            cell.payTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_orderModel.payTime integerValue]]];
        }
        if (!IsNull(_orderModel.sendTime)&&!IsNilString(_orderModel.sendTime)) {
            cell.sendTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_orderModel.sendTime integerValue]]];
        }
        cells = cell;
    }
    return cells;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 50)];
        headV.backgroundColor = [UIColor whiteColor];

        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 16, 150, 16)];
        [headV addSubview:titleLb];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.textColor =__DefaultColor;
        titleLb.font = MFont(16);
        titleLb.text = [NSString stringWithFormat:@"%@自营",ShortTitle];

        UIView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
        [headV addSubview:bottomIV];
        bottomIV.backgroundColor =__BackColor;
        return  headV;
    }else if (section==2){
        UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 24)];
        return headV;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 50;
        }else{
            return 70;
        }
    }else if (indexPath.section==1){
        if (_dataArr.count<=3) {
            return 100;
        }else{
            if (_show) {
              if (indexPath.row==_dataArr.count) {
                   return 40;
              }else{
                   return 100;
               }
            }else{
               if (indexPath.row==3) {
                    return 40;
                }else{
                    return 100;
                }
            }
        }
    }else if (indexPath.section==2){
        if (indexPath.row==3) {
            return 105;
        }else{
            return 56;
        }
    }else if (indexPath.section==3){
        return 40;
    }else{
        return 95;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 50;
    }else if (section==2){
        return 24;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            NSLog(@"选择地址");
        }
    }else if (indexPath.section==1){
        if (!_show&&indexPath.row==3) {
            _show =!_show;
            [_tableV reloadData];
        }else if (indexPath.row==_dataArr.count){
            _show =!_show;
            [_tableV reloadData];
        }
    }
}


#pragma mark ==YOrdersDetailActionBottomViewDelegate==
-(void)OrderBottomAction:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            NSLog(@"马上付款");
            YPayViewController *vc = [[YPayViewController alloc]init];
            vc.orderId = _orderId;
            vc.payMoney = _orderModel.payMoney;
            vc.addressModel = _addressModel;
            YShopGoodModel *model = _dataArr.firstObject;
            vc.orderName = model.goodTitle;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"申请退款");
            YApplyDrawbackViewController *vc = [[YApplyDrawbackViewController alloc]init];
            vc.goodArr = _dataArr;
            vc.order = _orderModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"查看物流");
            YLogisticsInfoViewController *vc = [[YLogisticsInfoViewController alloc]init];
            vc.orderId = _orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"确认收货");
            [self sureReceive];
        }
            break;
        case 4:
        {
            NSLog(@"马上评价");
            YEvaluteOrderViewController *vc = [[YEvaluteOrderViewController alloc]init];
            NSMutableArray *data = [NSMutableArray array];
            for (YShopGoodModel *model in _dataArr) {
                YOrderEvalueModel *emodel = [[YOrderEvalueModel alloc]init];
                emodel.goodId = model.goodId;
                emodel.orderId = _orderId;
                emodel.goodUrl = model.goodUrl;
                emodel.imageArr = [NSMutableArray array];
                [data addObject:emodel];
            }
            vc.list = data;
            vc.orderId = _orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            NSLog(@"再次购买");
            NSMutableArray *list = [NSMutableArray array];
            for (YShopGoodModel *good in _dataArr) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                [dic setValue:good.goodId forKey:@"goods_id"];
                [dic setValue:good.goodCount forKey:@"goods_num"];
                [list addObject:dic];
            }
            NSData *data = [NSJSONSerialization dataWithJSONObject:list options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            [self buyAgain:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"goods":jsonStr}];
//            YSureOrderViewController *vc = [[YSureOrderViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{
            [self cancelOrder];
        }
            break;
        default:
            break;
    }
}

#pragma mark ==YGroupDetailGoodCellDelegate==
- (void)chooseEvaluate:(YShopGoodModel *)model {
    YEvaluteOrderViewController *vc = [[YEvaluteOrderViewController alloc]init];
    YOrderEvalueModel *data = [[YOrderEvalueModel alloc]init];
    data.goodId = model.goodId;
    data.goodUrl = model.goodUrl;
    data.imageArr = [NSMutableArray array];
    vc.dataModel = data;
    vc.orderId = _orderId;
    [self.navigationController pushViewController:vc animated:YES];

}



- (void)sureReceive {
    [JKHttpRequestService POST:@"Afterbuy/goods_receipt" withParameters:@{@"order_id":_orderId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *arr = @[@"1"];
            [[NSNotificationCenter defaultCenter]postNotificationName:YSOrderStatusChange object:arr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)cancelOrder {
    [JKHttpRequestService POST:@"Order/order_cancel" withParameters:@{@"order_id":_orderId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *arr = @[@"1"];
            [[NSNotificationCenter defaultCenter]postNotificationName:YSOrderStatusChange object:arr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)buyAgain:(NSDictionary*)params {
   [JKHttpRequestService POST:@"Order/buyAgain" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           NSArray *arr = @[@"1"];
           [[NSNotificationCenter defaultCenter]postNotificationName:YSGoodAddtoShopCart object:arr];
           dispatch_async(dispatch_get_main_queue(), ^{
               YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
               tab.selectIndex = 2;
               [self.navigationController popToRootViewControllerAnimated:YES];
           });
       }
   } failure:^(NSError *error) {

   } animated:YES];
}
//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *tableview = (UITableView *)scrollView;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
