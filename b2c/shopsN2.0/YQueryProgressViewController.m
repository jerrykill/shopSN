//
//  YQueryProgressViewController.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YQueryProgressViewController.h"
#import "YQueryProgressCell.h"
#import "YQueryQuestionCell.h"
#import "YQueryViewCell.h"
#import "YQueryPhoneCell.h"

@interface YQueryProgressViewController ()<UITableViewDelegate,UITableViewDataSource,YQueryPhoneCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YReturnsOrdersModel *model;

@end

@implementation YQueryProgressViewController

- (void)getdata {
    [JKHttpRequestService POST:@"Pcenter/speed_check_list" withParameters:@{@"id":_orderId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _model = [YSParseTool getParseAfterSaleSpeedDetail:data[0]];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进度查询";
    [self initView];
    [self getdata];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.row==0) {
        YQueryProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YQueryProgressCell"];
        if (!cell) {
            cell = [[YQueryProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YQueryProgressCell"];
        }
        cell.model = _model.list.firstObject;
        cells =cell;
    }else if (indexPath.row==1||indexPath.row==2){
        YQueryQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YQueryQuestionCell"];
        if (!cell) {
            cell = [[YQueryQuestionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YQueryQuestionCell"];
        }
        if (indexPath.row==1) {
            cell.title = @"问题描述";
            cell.detail = _model.info;
//            cell.detail = @"电饭煲用来两分钟自动关机，煮不了饭没饭吃。";
        }else{
            cell.title = @"审核留言";
            cell.detail = _model.auditInfo;
//            cell.detail = @"您好，请联系美的售后4008-123-123寄回维修，谢谢！美的售后地址：广东省中山市新区梅村梅西路108号，电话：4008-123-123，联系人：美的售后（内附上纸条写明售后服务单号）寄出后留下快递底单方便后期查询进度，谢谢！";
        }
        cells = cell;
    }else if (indexPath.row==3){
        YQueryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YQueryViewCell"];
        if (!cell) {
            cell = [[YQueryViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YQueryViewCell"];
        }

        cell.dataArr = _model.datas;
        cells = cell;
    }else{
        YQueryPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YQueryPhoneCell"];
        if (!cell) {
            cell = [[YQueryPhoneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YQueryPhoneCell"];
        }
        cell.delegate = self;
        cells =cell;
    }
    return cells;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return  180;
    }else if (indexPath.row==1){
         NSString  *str = _model.info;
         CGSize size =[str boundingRectWithSize:CGSizeMake(__kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
        return size.height+85;
    }else if (indexPath.row==2){
        NSString  *str =_model.auditInfo;
        CGSize size =[str boundingRectWithSize:CGSizeMake(__kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
        return size.height+85;
    }else if (indexPath.row==3){
        return 80+85*_model.datas.count;
    }else{
        return 85;
    }
}

#pragma mark ==YQueryPhoneCellDelegate==
-(void)makePhone{
    NSLog(@"拨打客服电话");
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:18855584908"]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
