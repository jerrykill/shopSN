//
//  YSAnnouncementViewController.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSAnnouncementViewController.h"
#import "YAnnounceCell.h"
#import "YSAnnounceDetailViewController.h"
#import "YWarnModel.h"

@interface YSAnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YSAnnouncementViewController

-(void)getdata{
   WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
  [JKHttpRequestService POST:@"Index/announcement" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
      if (succe) {
          NSArray *data = jsonDic[@"data"];
          strongSelf.dataArr = [YSParseTool getParseAnnounce:data];
          [strongSelf.tableV reloadData];
      }
  } failure:^(NSError *error) {

  } animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"公告";
    self.rightBtn.hidden = YES;
    [self getdata];
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+10, __kWidth, __kHeight-74-50)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YAnnounceCell"];
    if (!cell) {
        cell = [[YAnnounceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YAnnounceCell"];
    }
    YWarnModel *model = _dataArr[indexPath.row];
    cell.title = model.warnTitle;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YWarnModel *model = _dataArr[indexPath.row];
    YSAnnounceDetailViewController *vc = [[YSAnnounceDetailViewController alloc]init];
    vc.warnId = model.warnId;
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
