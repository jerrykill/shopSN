//
//  YConsAddRecordViewController.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YConsAddRecordViewController.h"
#import "YConsRecordHeadView.h"
#import "YConsRecordCell.h"
#import "YAddConsModel.h"

@interface YConsAddRecordViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YConsRecordHeadView *recordHeadV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YConsAddRecordViewController


-(void)getData{
    _dataArr = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        YConsModel *model = [[YConsModel alloc]init];
        model.date = @"2016/12/01";
        model.title = @"得力A4纸4000张...";
        model.num = @"16只";
        if (!i) {
            model.status = @"配送中";
        }else{
            model.status = @"已送达";
        }
        [_dataArr addObject:model];
    }
    [_tableV reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补充耗材记录";

    [self initView];
    [self getData];
}

-(void)initView{
    _recordHeadV = [[YConsRecordHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 45)];

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

    _tableV.tableHeaderView = _recordHeadV;

}


#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YConsRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YConsRecordCell"];
    if (!cell) {
        cell = [[YConsRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YConsRecordCell"];
    }
    YConsModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
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
