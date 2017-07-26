//
//  YGiftFilterViewController.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftFilterViewController.h"
#import "YGiftFilterNaviView.h"
#import "YGiftGoodCell.h"
#import "YGiftAreaPickerView.h"
#import "YGiftGoodDetailViewController.h"

@interface YGiftFilterViewController ()<YGiftFilterNaviViewDelegate,YPopViewDelegate,UITableViewDelegate,UITableViewDataSource,YGiftAreaPickerViewDelegate>

@property (strong,nonatomic) YGiftFilterNaviView *naviV;

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YGiftAreaPickerView *pickerV;

@property (strong,nonatomic) NSString *num;

@end

@implementation YGiftFilterViewController

-(void)getData{
    [JKHttpRequestService POST:@"Integral/integral_goods" withParameters:@{@"num":_num} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _dataArr = [YSParseTool getParseGiftGoods:data];
            [_tableView reloadData];
        }else{
            [_dataArr removeAllObjects];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _num = @"";
    [self initView];
    [self getData];
}

-(void)addNavigationBar{
    _naviV = [[YGiftFilterNaviView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:_naviV];
    [self.view bringSubviewToFront:_naviV];
    _naviV.delegate = self;
}


-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = __BackColor;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark ==YGiftFilterNaviViewDelegate==
-(void)giftNaviAction:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:
        {
            [self getPicker];
        }
            break;
        case 2:
        {
            [self chooseRight];
        }
            break;
        default:
            break;
    }
}
- (void)getPicker{
    _pickerV = [[YGiftAreaPickerView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self.view addSubview:_pickerV];
    _pickerV.delegate = self;
    _pickerV.listArr = @[@"积分筛选",@"1-999",@"1000-1999",@"2000-2999",@"3000-3999"];

}

#pragma mark ==YGiftAreaPickerViewDelegate==
-(void)chooseIntegral:(NSString *)text{
    NSLog(@"%@",text);
    if ([text isEqualToString:@"积分筛选"]) {
        _num = @"";
    }else{
        _num = text;
    }
    _naviV.title = text;
    [self getData];
}


- (void)chooseRight{
    NSArray *list = @[@"首页",@"消息"];
    NSArray *images =@[@"home",@"news"];

    _popV = [[YPopView alloc]initWithFrame:CGRectMake(__kWidth-40, 8, __kWidth, __kHeight-60) title:list image:images];
    [self.view addSubview:_popV];
    _popV.delegate = self;
    _popV.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:_popV];
}

#pragma mark ==YPopViewDelegate==
-(void)chooseIndex:(NSInteger)index{
    if (index==0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
            tab.selectIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else{
        YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGiftGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGiftGoodCell"];
    if (!cell) {
        cell = [[YGiftGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGiftGoodCell"];
    }
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    YGiftGoodDetailViewController *vc = [[YGiftGoodDetailViewController alloc]init];
    vc.model = _dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_popV removeFromSuperview];
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
