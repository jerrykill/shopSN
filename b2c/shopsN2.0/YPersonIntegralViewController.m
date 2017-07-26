//
//  YPersonIntegralViewController.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonIntegralViewController.h"
#import "YPersonIntegralCell.h"
#import "YPersonIntegralHeadView.h"
#import "YPersonIntegralModel.h"
#import "YIntegralRuleView.h"

#import "YGiftFilterViewController.h"

@interface YPersonIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YPersonIntegralHeadView *header;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YIntegralRuleView *ruleV;

@property (strong,nonatomic) NSString *total;

@property (strong,nonatomic) NSString *change;

@end

@implementation YPersonIntegralViewController

-(void)getData{
//    _dataArr = [[NSMutableArray alloc]init];
//    for (int i=0; i<4; i++) {
//        YPersonIntegralModel *model = [[YPersonIntegralModel alloc]init];
//        model.time = @"2016/11/15";
//        if (i%2) {
//            model.title = @"订单消费金额6000.00元";
//            model.change = @"+600";
//        }else{
//            model.title = @"100积分兑换杯子";
//            model.change = @"-100";
//        }
//        [_dataArr addObject:model];
//    }
//    _tableV.contentSize = CGSizeMake(0, 175+60*_dataArr.count);
//    [_tableV reloadData];

    [JKHttpRequestService POST:@"Integral/integral" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            _header.total = [NSString stringWithFormat:@"%@",data[@"sum"]];
            NSString *changes = [NSString stringWithFormat:@"%@",data[@"situation"]];
            if ([changes containsString:@"-"]) {
                _header.change = changes;
            }else{
                _header.change = [NSString stringWithFormat:@"+%@",changes];
            }
            _dataArr = [YSParseTool getParseGiftHistory:data[@"list"]];
            _tableV.contentSize = CGSizeMake(0, 175+60*_dataArr.count);
            [_tableV reloadData];

        }
    } failure:^(NSError *error) {

    } animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    [self getNaviRule];
    [self initView];
    [self getData];
}

-(void)getNaviRule{
    UIButton *ruleBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-82, 30, 30, 26)];
    [self.headV addSubview:ruleBtn];
    ruleBtn.backgroundColor = [UIColor clearColor];
    ruleBtn.titleLabel.font = MFont(14);
    [ruleBtn setTitle:@"规则" forState:BtnNormal];
    [ruleBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [ruleBtn addTarget:self action:@selector(seeRule) forControlEvents:BtnTouchUpInside];

}

-(void)initView{

    _header = [[YPersonIntegralHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 175)];
//    _header.total = @"120000";
//    _header.change = @"+10";

    _tableV  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-45)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.tableHeaderView =_header;


    UIButton *exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 45)];
    [self.view addSubview:exchangeBtn];
    exchangeBtn.backgroundColor = __DefaultColor;
    exchangeBtn.titleLabel.font = MFont(16);
    [exchangeBtn setTitle:@"马上兑换商品" forState:BtnNormal];
    [exchangeBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [exchangeBtn addTarget:self action:@selector(makeExchange) forControlEvents:BtnTouchUpInside];
}

#pragma mark ==懒加载==
-(YIntegralRuleView *)ruleV{
    if (!_ruleV) {
        [SXLoadingView showProgressHUD:@""];
        _ruleV = [[YIntegralRuleView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    }

    return _ruleV;
}

#pragma mark ==查看规则==
- (void)seeRule{
    NSLog(@"查看规则");
    [self.view addSubview:self.ruleV];
    
}


#pragma mark ==兑换商品==
-(void)makeExchange{
    NSLog(@"兑换商品");
    YGiftFilterViewController *vc = [[YGiftFilterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPersonIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPersonIntegralCell"];
    if (!cell) {
        cell = [[YPersonIntegralCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPersonIntegralCell"];
    }
    YPersonIntegralModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
