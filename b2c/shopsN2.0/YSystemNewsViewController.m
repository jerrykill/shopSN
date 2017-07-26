//
//  YSystemNewsViewController.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSystemNewsViewController.h"
#import "YSystemNewsCell.h"
#import "YMessageDetailViewController.h"
#import "YNewsNullView.h"
#import "YSMessageModel.h"

@interface YSystemNewsViewController ()<UITableViewDelegate,UITableViewDataSource,YNewsNullViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *imageArr;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSArray *detailArr;

@property (strong,nonatomic) NSArray *timeArr;

@property (strong,nonatomic) YNewsNullView *newsNullV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YSystemNewsViewController

- (void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"News/my_news" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            strongSelf.dataArr = [YSParseTool getParsePersonNews:data];
            if (strongSelf.dataArr.count==0) {
                strongSelf.newsNullV.hidden = NO;
                strongSelf.tableV.hidden = YES;
            }else{
                strongSelf.newsNullV.hidden = YES;
                strongSelf.tableV.hidden = NO;
            }
            [strongSelf.tableV reloadData];
        }else{
            strongSelf.newsNullV.hidden = NO;
            strongSelf.tableV.hidden = YES;
        }
    } failure:^(NSError *error) {
        strongSelf.newsNullV.hidden = NO;
        strongSelf.tableV.hidden = YES;
    } animated:YES];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    self.rightBtn.hidden = YES;
    [self getdata];
    [self initView];
}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, __kWidth, __kHeight-74)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;


    _newsNullV = [[YNewsNullView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_newsNullV];
    _newsNullV.delegate = self;
    [self.view bringSubviewToFront:_newsNullV];
    _newsNullV.hidden = YES;
}

#pragma mark ==YNewsNullViewDelegate==
-(void)goBuying{
    dispatch_async(dispatch_get_main_queue(), ^{
        YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
        tab.selectIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSystemNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSystemNewsCell"];
    if (!cell) {
        cell = [[YSystemNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSystemNewsCell"];
    }

    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YSMessageModel *model = _dataArr[indexPath.row];
    YMessageDetailViewController *vc = [[YMessageDetailViewController alloc]init];
    vc.messageId = model.newsId;
    [self.navigationController pushViewController:vc animated:YES];
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
