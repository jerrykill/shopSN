//
//  YOrderChangePayAndSendViewController.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderChangePayAndSendViewController.h"
#import "YPayAndSendChooseCell.h"
#import "YSureOrderViewController.h"
#import "YGiftSureOrderViewController.h"

@interface YOrderChangePayAndSendViewController ()<UITableViewDelegate,UITableViewDataSource,YPayAndSendChooseCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic)  UIButton *saveBtn;

@property (strong,nonatomic) NSMutableArray *list;

@end

@implementation YOrderChangePayAndSendViewController


- (void)getdata {
    [JKHttpRequestService POST:@"order/Shipping" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"address_id":_addressId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _list = [YSParseTool getParseTitleList:data];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改支付配送方式";
    _dataArr = [NSMutableArray array];
    YServiceTitleModel *model = [[YServiceTitleModel alloc]init];
    [_dataArr addObject:model];
    [_dataArr addObject:@""];
    self.rightBtn.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });
    
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 320)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor =__BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

    _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV), __kWidth-20, 45)];
    [self.view addSubview:_saveBtn];
    _saveBtn.backgroundColor =__DefaultColor;
    _saveBtn.titleLabel.font = MFont(18);
    [_saveBtn setTitle:@"保存支付及配送方式" forState:BtnNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_saveBtn addTarget:self action:@selector(savePS) forControlEvents:BtnTouchUpInside];

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPayAndSendChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPayAndSendChooseCell"];
    if (!cell) {
        cell = [[YPayAndSendChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPayAndSendChooseCell"];
    }
    cell.tag = indexPath.section;
    cell.delegate = self;
    if (indexPath.section==0) {
        YServiceTitleModel *model = [[YServiceTitleModel alloc]init];
        model.titleName = @"在线支付";
        cell.chooseList = @[model];
    }else{
        YServiceTitleModel *model = _list.firstObject;
        cell.chooseList = _list;
        if (!IsNilString(_sendType)) {
            if ([_sendType isEqualToString:model.titleName]) {
                cell.choose = 201;
            }else{
                cell.choose = 202;
            }
        }
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 45)];
    header.backgroundColor =__BackColor;

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kWidth-100, 15)];
    [header addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.textColor = __TextColor;
    titleLb.font = MFont(15);
    if (section==0) {
        titleLb.text = @"支付方式";
    }else{
        titleLb.text = @"配送方式";
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 45;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}


#pragma mark ==YPayAndSendChooseCellDelegate==
-(void)chooseType:(NSString *)sender index:(NSInteger)index{
    YServiceTitleModel *model = _list[index];
    [_dataArr replaceObjectAtIndex:1 withObject:model];
}

#pragma mark ==保存==
- (void)savePS{
    NSLog(@"保存");
    NSArray *vcs = self.navigationController.viewControllers;
    NSInteger vcCount = vcs.count;

    if ([vcs[vcCount-2] isKindOfClass:[YSureOrderViewController class]]||[vcs[vcCount-2] isKindOfClass:[YGiftSureOrderViewController class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YSPayAndSendChange object:_dataArr userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
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
