//
//  YBuyingLeadsOrderViewController.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingLeadsOrderViewController.h"
#import "YBuyingOrderTitleCell.h"
#import "YBuyingChooseCell.h"
#import "YBuyingLeadsHeadView.h"
#import "YBuyingOrderDateCell.h"
#import "YBuyingLeadsBottomView.h"
#import "YBuyingGoodsViewController.h"
#import "YBuyingDatePicker.h"

@interface YBuyingLeadsOrderViewController ()<YBuyingOrderTitleCellDelegate,YBuyingChooseCellDelegate,UITableViewDelegate,UITableViewDataSource,YBuyingOrderDateCellDelegate,YBuyingGoodsViewControllerDelegate,YBuyingDatePickerDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSString *date;

@property (strong,nonatomic) NSString *state;

@property (strong,nonatomic) YBuyingDatePicker *datePickV;

@end

@implementation YBuyingLeadsOrderViewController

-(void)putData{
    [self checkNUll];
    NSMutableArray*num = [NSMutableArray array];
    for (YBuyingGoodModel*model in _model.goodArr) {
        [num addObject:model.goodID];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:num options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    WK(weakSelf)
    [JKHttpRequestService POST:@"Pcenter/purchase" withParameters:@{@"purchase_id":_model.purchaseId,@"purchase_title":_model.title,@"purchase_type":_model.type,@"purchase_goods_id":jsonStr,@"total_price":_model.total,@"contacts":_model.cusName,@"tel":_model.phone,@"overtime":_model.date,@"pay_type":_model.payType,@"invoice":_model.billType,@"explain":_model.info,@"state":_state,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            __typeof(&*weakSelf) strongSelf = weakSelf;
            [SXLoadingView showAlertHUD:@"提交成功" duration:SXLoadingTime];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)checkNUll{
    if (IsNilString(_model.title)||IsNilString(_model.type)||!_model.goodArr.count||IsNilString(_model.cusName)||IsNilString(_model.phone)) {
        [SXLoadingView showAlertHUD:@"信息不全" duration:SXLoadingTime];
        return;
    }
    if(IsNilString(_model.date)){
      _model.date = @"";
    }
    if(IsNilString(_model.purchaseId)){
        _model.purchaseId = @"";
    }
    if (IsNilString(_model.info)) {
        _model.info = @"";
    }
}

-(void)getdata{
    if (!IsNilString(_model.purchaseId)) {
        WK(weakSelf)
        [JKHttpRequestService GET:@"Pcenter/needOrderUp" withParameters:@{@"purchase_id":_model.purchaseId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                __typeof(&*weakSelf) strongSelf = weakSelf;
                strongSelf.model = [YSParseTool getParsePurchas:jsonDic[@"data"]];
                [strongSelf.tableV reloadData];
            }
        } failure:^(NSError *error) {
            
        } animated:YES];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_model) {
        _model = [[YBuyingLeadsModel alloc]init];
    }else{
        _isEdit =_model.status;
    }
    self.title = @"采购需求单";
    [self initView];
    [self getdata];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-114)];
    [self.view addSubview:_tableV];
    [self.view sendSubviewToBack:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor =  [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource =self;


    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 50)];
    [self.view addSubview:bottomV];
    bottomV.backgroundColor = [UIColor whiteColor];

    UIButton*putBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, __kWidth/2-20, 40)];
    [bottomV addSubview:putBtn];
    putBtn.layer.cornerRadius = 5;
    putBtn.backgroundColor = LH_RGBCOLOR(109, 109, 109);
    putBtn.titleLabel.font = MFont(16);
    [putBtn setTitle:@"提交" forState:BtnNormal];
    [putBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [putBtn addTarget:self action:@selector(choosePut) forControlEvents:BtnTouchUpInside];

    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth/2+10, 5, __kWidth/2-20, 40)];
    [bottomV addSubview:saveBtn];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.backgroundColor = LH_RGBCOLOR(224, 40, 40);
    saveBtn.titleLabel.font = MFont(16);
    [saveBtn setTitle:@"保存" forState:BtnNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [saveBtn addTarget:self action:@selector(chooseSave) forControlEvents:BtnTouchUpInside];

}

#pragma mark ==提交==
-(void)choosePut{
    NSLog(@"提交");
    if ([_isEdit isEqualToString:@"1"]||IsNilString(_isEdit)) {
        _state = @"2";
        [self putData];
    }else{
        [SXLoadingView showAlertHUD:@"已提交状态，修改无效" duration:SXLoadingTime];
    }

}
#pragma mark ==保存==
-(void)chooseSave{
    NSLog(@"保存");
  if ([_isEdit isEqualToString:@"1"]||IsNilString(_isEdit)) {
      _state = @"1";
       [self putData];
  }else{
      [SXLoadingView showAlertHUD:@"已提交状态，修改无效" duration:SXLoadingTime];
  }
}
#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else{
        return 6;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            YBuyingChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingChooseCell"];
            if (!cell) {
                cell = [[YBuyingChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingChooseCell"];
            }
            cell.title = @"需求类型：";
            cell.chooseArr = @[@"询货",@"询价",@"询交期"];
            if (!IsNilString(_model.type)) {
                cell.choose = cell.chooseArr[[_model.type integerValue]-1];
            }
            cell.tag = 200;
            cell.delegate = self;
            cells = cell;
        }else{
            YBuyingOrderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingOrderTitleCell"];
            if (!cell) {
                cell = [[YBuyingOrderTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingOrderTitleCell"];
            }
            if (indexPath.row==0) {
                cell.title = @"标题：";
                cell.plachor = @"请输入采购需求标题...";
                if (!IsNilString(_model.title)) {
                    cell.detail = _model.title;
                }
                cell.tag = 100;
            }else{
                cell.title = @"采购商品：";
                cell.plachor = @"请填写采购商品信息...";
                cell.edit = NO;
                if (_model.goodArr.count) {
                    cell.detail = [NSString stringWithFormat:@"%ld件商品",_model.goodArr.count];
                }
                cell.tag = 101;
            }
            cell.delegate = self;
            cells = cell;
        }
    }else{
        if (indexPath.row==2) {
            YBuyingOrderDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingOrderDateCell"];
            if (!cell) {
                cell = [[YBuyingOrderDateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingOrderDateCell"];
            }
            if (!IsNilString(_model.date)) {
                cell.date = _model.date;
            }
            cell.delegate = self;
            cells = cell;
        }else if (indexPath.row==0||indexPath.row==1||indexPath.row==5){
            YBuyingOrderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingOrderTitleCell"];
            if (!cell) {
                cell = [[YBuyingOrderTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingOrderTitleCell"];
            }
            if (indexPath.row==0) {
                cell.title = @"联系人：";
                cell.plachor = @"请输入联系人...";
                if (!IsNilString(_model.cusName)) {
                    cell.detail = _model.cusName;
                }
                cell.tag = 102;
            }else if (indexPath.row==1){
                cell.title = @"联系电话：";
                cell.plachor = @"请输入联系电话...";
                if (!IsNilString(_model.phone)) {
                    cell.detail = _model.phone;
                }
                cell.tag = 103;
            }else{
                cell.title = @"补充说明：";
                cell.plachor = @"请输入补充说明...";
                if (!IsNilString(_model.info)) {
                    cell.detail = _model.info;
                }
                cell.tag = 104;
            }
            cell.delegate = self;
            cells= cell;
        }else{
            YBuyingChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingChooseCell"];
            if (!cell) {
                cell = [[YBuyingChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingChooseCell"];
            }
            if (indexPath.row==3) {
                cell.title = @"支付方式：";
                cell.chooseArr = @[@"在线支付",@"合约客户支付"];
                if (!IsNilString(_model.payType)) {
                    cell.choose = cell.chooseArr[[_model.payType integerValue]-1];
                }
                cell.tag = 201;
            }else{
                cell.title = @"发票信息：";
                cell.chooseArr = @[@"普通发票",@"增值发票"];
                if (!IsNilString(_model.billType)) {
                    cell.choose = cell.chooseArr[[_model.billType integerValue]-1];;
                }
                cell.tag = 202;
            }
            cell.delegate = self;
            cells = cell;
        }
    }
    return cells;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YBuyingLeadsHeadView *header = [[YBuyingLeadsHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 45)];
    if (section==0) {
        header.title = @"采购需求单";
        header.imageName = @"purchase1";
    }else{
        header.title = @"采购要求";
        header.imageName = @"purchase2";
    }
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        YBuyingLeadsBottomView *footer = [[YBuyingLeadsBottomView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 50)];
        if (!IsNilString(_model.total)) {
            footer.title = _model.total;
        }else{
            footer.title = @"0.00";
        }
        return footer;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 50;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==2) {
        NSLog(@"采购商品");
        YBuyingGoodsViewController *vc = [[YBuyingGoodsViewController alloc]init];
        if (_model.goodArr.count) {
          vc.dataArr = _model.goodArr;
        }
        vc.status =_isEdit;
        vc.orderId = _model.purchaseId;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==1&&indexPath.row==2){
        NSLog(@"选择日期");
    }
}



#pragma mark ==YBuyingOrderTitleCellDelegate==
-(void)Getdetail:(NSString *)sender Index:(NSInteger)tag{
    NSLog(@"%@%ld",sender,tag);
    switch (tag) {
        case 0:
        {
            _model.title = sender;
        }
            break;
        case 2:
        {
            _model.cusName = sender;
        }
            break;
        case 3:
        {
            _model.phone = sender;
        }
            break;
        case 4:
        {
            _model.info = sender;
        }
            break;
        default:
            break;
    }
}


#pragma mark ==YBuyingChooseCellDelegate==
-(void)chooseType:(NSString *)type index:(NSInteger)tag{
    NSLog(@"%@%ld",type,tag);
    switch (tag) {
        case 0:
        {
            NSArray *types = @[@"询货",@"询价",@"询交期"];
            for (int i=0; i<types.count; i++) {
                if ([type isEqualToString:types[i]]) {
                    _model.type = [NSString stringWithFormat:@"%d",i+1];
                }
            }

        }
            break;
        case 1:
        {
            NSArray *types = @[@"在线支付",@"合约客户支付"];
            for (int i=0; i<types.count; i++) {
                if ([type isEqualToString:types[i]]) {
                    _model.payType = [NSString stringWithFormat:@"%d",i+1];
                }
            }
        }
            break;
        case 2:
        {
            NSArray *types = @[@"普通发票",@"增值发票"];
            for (int i=0; i<types.count; i++) {
                if ([type isEqualToString:types[i]]) {
                    _model.billType = [NSString stringWithFormat:@"%d",i+1];
                }
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark ==YBuyingOrderDateCellDelegate==
-(void)changeFramed{
 _tableV.transform =CGAffineTransformMakeTranslation(0, __kHeight-(140+180+45*2+270+64)+_tableV.contentOffset.y);
    [self.view addSubview:self.datePickV];
    [self.view bringSubviewToFront:_datePickV];
}

-(YBuyingDatePicker *)datePickV{
    if (!_datePickV) {
        _datePickV = [[YBuyingDatePicker alloc]initWithFrame:CGRectMake(0, __kHeight-260, __kWidth, 260)];
        _datePickV.delegate = self;
    }
    return _datePickV;
}

#pragma mark ==YBuyingDatePickerDelegate==
-(void)chooseDateTime:(NSString *)sender{
    _tableV.transform =CGAffineTransformIdentity;
    NSLog(@"日期%@",sender);
    _model.date = sender;
    [_tableV reloadData];
}

- (void)hiddenView{
    _tableV.transform =CGAffineTransformIdentity;
}

#pragma mark ==YBuyingGoodsViewControllerDelegate==
-(void)chooseGoodList:(NSMutableArray<YBuyingGoodModel *> *)data{
    _model.goodArr =data;
    CGFloat moeny =0.00;
    for (YBuyingGoodModel*good in _model.goodArr) {
        moeny +=[good.goodMoney floatValue]*[good.goodCount integerValue];
    }
    _model.total = [NSString stringWithFormat:@"%.2f",moeny];
    [_tableV reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    UITableView *tableview = (UITableView *)scrollView;
//    CGFloat sectionHeaderHeight = 45;
//    CGFloat sectionFooterHeight = 50;
//    CGFloat offsetY = tableview.contentOffset.y;
//    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
//    {
//        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
//    {
//        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
//    {
//        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
//    }
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
