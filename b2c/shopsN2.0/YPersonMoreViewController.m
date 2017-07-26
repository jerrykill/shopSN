//
//  YPersonMoreViewController.m
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonMoreViewController.h"
#import "YPersonMoreCell.h"
#import "YSettingViewController.h"
#import "YAboutViewController.h"

@interface YPersonMoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSArray *imageArr;

@end

@implementation YPersonMoreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    _titleArr = @[@"设置",@"关于"];
    _imageArr = @[@"more_sz",@"more_gy"];
    [self initView];
}

-(void)initView{
    _tableV  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+5, __kWidth, __kHeight-64-50)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.scrollEnabled = NO;
    _tableV.delegate = self;
    _tableV.dataSource = self;

    UIButton *goOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 45)];
    [self.view addSubview:goOutBtn];
    goOutBtn.backgroundColor = __DefaultColor;
    goOutBtn.titleLabel.font = MFont(16);
    [goOutBtn setTitle:@"退出当前账户" forState:BtnNormal];
    [goOutBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [goOutBtn addTarget:self action:@selector(goOut) forControlEvents:BtnTouchUpInside];
}
#pragma mark ==退出==
-(void)goOut{
    NSLog(@"退出");
    [UdStorage storageObject:@"" forKey:Userid];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            NSLog(@"退出成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
                tab.selectIndex = 0;
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    } onQueue:nil];

}
#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPersonMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPersonMoreCell"];
    if (!cell) {
        cell = [[YPersonMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPersonMoreCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLb.text = _titleArr[indexPath.row];
    cell.headIV.image = MImage(_imageArr[indexPath.row]);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.row==0) {
        YSettingViewController *vc = [[YSettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YAboutViewController *vc = [[YAboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
