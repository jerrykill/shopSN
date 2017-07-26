//
//  YPersonAppraiseViewController.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonAppraiseViewController.h"
#import "YPersonAppraiseTypeView.h"
#import "YPersonAppraiseCell.h"


@interface YPersonAppraiseViewController ()<YPersonAppraiseTypeViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YPersonAppraiseTypeView *typeHeadV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (assign,nonatomic) NSInteger page;

@property (assign,nonatomic) BOOL isPic;

@end

@implementation YPersonAppraiseViewController


-(void)getData{
    _tableV.contentOffset = CGPointMake(0, 0);
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/myComment" withParameters:@{@"p":@"1",@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic =jsonDic[@"data"];
            NSDictionary *num = dic[@"num"];
            strongSelf.typeHeadV.countArr = @[num[@"count"],num[@"img"]];
            strongSelf.dataArr = [YSParseTool getParsePersonParise:dic[@"list"]];
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.tableV setFooterHidden:YES];
        }
    } failure:^(NSError *error) {
       
    } animated:YES];

}
-(void)getImageData{
    _tableV.contentOffset = CGPointMake(0, 0);
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/imgComment" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            strongSelf.dataArr = [YSParseTool getParsePersonParise:jsonDic[@"data"]];
            [strongSelf.tableV reloadData];
            [strongSelf.tableV setFooterHidden:NO];
        }else{
            [strongSelf.tableV setFooterHidden:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)loadMore{
    _page++;
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if (_isPic) {
        [JKHttpRequestService GET:@"Pcenter/imgComment" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSDictionary *dic =jsonDic[@"data"];
                NSMutableArray *data = [YSParseTool getParsePersonParise:dic];
                [strongSelf.dataArr addObjectsFromArray:data];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV footerEndRefreshing];
            }else{
                strongSelf.page--;
                [strongSelf.tableV.footer endRefreshing];
                [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    }else{
    [JKHttpRequestService GET:@"Pcenter/myComment" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic =jsonDic[@"data"];
            NSMutableArray *data = [YSParseTool getParsePersonParise:dic[@"list"]];
            [strongSelf.dataArr addObjectsFromArray:data];
            [strongSelf.tableV reloadData];
            [strongSelf.tableV footerEndRefreshing];
            [strongSelf.tableV setFooterHidden:YES];
            [strongSelf.tableV setFooterHidden:NO];
        }else{
            strongSelf.page--;
            [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
  }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page=1;
    _isPic=NO;
    self.title = @"我的评价";
    [self initView];
    [self getData];
}

-(void)initView{
    _typeHeadV = [[YPersonAppraiseTypeView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 60)];
    [self.view addSubview:_typeHeadV];
    _typeHeadV.delegate = self;

    
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, __kWidth, __kHeight-130)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [_tableV addFooterWithTarget:self action:@selector(loadMore)];

}
#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPersonAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPersonAppraiseCell"];
    if (!cell) {
        cell = [[YPersonAppraiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPersonAppraiseCell"];
    }

    YGoodAppraiseModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodAppraiseModel *model = _dataArr[indexPath.row];
    NSString *text = model.info;
    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(12)} context:nil].size;
    NSInteger t =0;
    CGFloat height=0;
    if (model.imageArr.count) {
        t=1;
    }
    height = 70+size.height+t*70+41;
    return height;
}

#pragma mark ==YPersonAppraiseTypeViewDelegate==
-(void)chooseView:(NSInteger)tag{
    _page=1;
    if (tag) {
        NSLog(@"有图评论");
        _isPic = YES;
        [self getImageData];
    }else{
        NSLog(@"发布评论");
        _isPic= NO;
        [self getData];
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
