//
//  YLogisticsInfoViewController.m
//  shopsN
//
//  Created by imac on 2016/12/26.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YLogisticsInfoViewController.h"
#import "YLogisicsInfoCell.h"

@interface YLogisticsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *mainV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YLogisticsInfoViewController


- (void)getdata {
    [JKHttpRequestService POST:@"Afterbuy/express" withParameters:@{@"order_id":_orderId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"][@"data"];
            if (data.count) {
                _dataArr = [YSParseTool getParseOrderLogisicInfo:data];
                [_mainV reloadData];
            }else{
                [SXLoadingView showAlertHUD:@"暂无物流信息" duration:SXLoadingTime];
            }
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流查询";
    self.rightBtn.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });
}

-(void)initView{
    _mainV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_mainV];
    _mainV.backgroundColor = __BackColor;
    _mainV.separatorColor = [UIColor clearColor];
    _mainV.delegate = self;
    _mainV.dataSource = self;
   
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLogisicsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YLogisicsInfoCell"];
    if (!cell) {
        cell = [[YLogisicsInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YLogisicsInfoCell"];
    }
    YLogisicsInfoModel *model =_dataArr[indexPath.row];
    if (indexPath.row==0) {
        cell.data = model;
        cell.type = 1;
    }else if (indexPath.row==_dataArr.count-1){
        cell.data = model;
        cell.type =0;
    }else{
        cell.data = model;
        cell.type = 2;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLogisicsInfoModel *model =_dataArr[indexPath.row];
    NSString *text = model.info;
    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-45-38, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(15)} context:nil].size;
    return 41+size.height+20;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
