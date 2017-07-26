//
//  YInfoServiceViewController.m
//  shopsN
//
//  Created by imac on 2017/1/20.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YInfoServiceViewController.h"
#import "YSearchPushView.h"
#import "YServiceMessageViewController.h"

@interface YInfoServiceViewController ()<YSearchPushViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) YSearchPushView *headerV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YInfoServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    [self getNavi];
    [self initView];
}

-(void)getNavi{
    _headerV = [[YSearchPushView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"请输入检索信息.."];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
    _headerV.searchTF.attributedPlaceholder = attr;
    [self.view addSubview:_headerV];
    _headerV.delegate = self;
}


-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==YSearchPushViewDelegate==
-(void)chooseBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchDid:(NSString *)text{
    NSLog(@"检索%@",text);
    [self getData:text];
    [self.view endEditing:YES];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, __kWidth, 1)];
        [cell.contentView addSubview:lineIV];
        lineIV.backgroundColor = __BackColor;
    }
    YServiceTitleModel *model =_dataArr[indexPath.row];
    cell.textLabel.text = model.titleName;
    cell.textLabel.font = MFont(15);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YServiceTitleModel *model = _dataArr[indexPath.row];
    YServiceMessageViewController *vc = [[YServiceMessageViewController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)getData:(NSString*)search{
    [JKHttpRequestService POST:@"Pcenter/articleSearch" withParameters:@{@"keyword":search} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _dataArr = [YSParseTool getParseTitleList:data];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

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
