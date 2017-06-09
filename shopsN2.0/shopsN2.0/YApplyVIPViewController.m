//
//  YApplyVIPViewController.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyVIPViewController.h"
#import "YVIPApplyHeadSectionView.h"
#import "YApplyDetailCell.h"
#import "YApplyStrengthsCell.h"
#import "YApplySureCell.h"
#import "YApplyProgressCell.h"

#import "YCustomAccountPayApplyViewController.h"

@interface YApplyVIPViewController ()<UITableViewDelegate,UITableViewDataSource,YApplySureCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *sectionArr;

@end

@implementation YApplyVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请VIP合约用户";
    self.rightBtn.frame = CGRectMake(__kWidth-70, 35, 58, 15);
    self.rightBtn.titleLabel.font = MFont(14);
    self.rightBtn.backgroundColor = [UIColor clearColor];
    [self.rightBtn setImage:MImage(@"") forState:BtnNormal];
    [self.rightBtn setTitle:@"马上申请" forState:BtnNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    _sectionArr = @[@"一、什么是账期支付？",@"二、优势：",@"三、申请条件：",@"四、使用流程：",@"五、注意事项"];
    [self initView];
}

- (void)chooseRight{
    [self chooseApply];
}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.delegate = self;
    _tableV.dataSource = self;

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells =nil;
    if (indexPath.section==0) {
        YApplyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplyDetailCell"];
        if (!cell) {
            cell= [[YApplyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplyDetailCell"];
        }
        cell.title = @"账期支付是指，符合条件的用户在审核通过后不用付款就可以进货，在确认收货后的结算日期内完成支付的交易方式。";
        cells = cell;
    }else if (indexPath.section==1){
        YApplyStrengthsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplyStrengthsCell"];
        if (!cell) {
            cell = [[YApplyStrengthsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplyStrengthsCell"];
        }
        cells = cell;
    }else if (indexPath.section==2){
        YApplySureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplySureCell"];
        if (!cell) {
            cell = [[YApplySureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplySureCell"];
        }
        cell.delegate = self;
        cells =cell;
    }else if (indexPath.section ==3){
        YApplyProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplyProgressCell"];
        if (!cell) {
            cell = [[YApplyProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplyProgressCell"];
        }
        cells =cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *titleLb = [[UILabel alloc]init];
            titleLb.textAlignment = NSTextAlignmentLeft;
            titleLb.textColor = LH_RGBCOLOR(120, 120, 120);
            titleLb.numberOfLines =0;
            titleLb.font =MFont(15);
            CGSize size = [YGetAttribute getSpaceHeight:@"1.用户在确认比较申请表格后，可于48小时内查看审核结果。\n2.该服务解释权在法律规定的范围内归shopsN商城所有。" size:CGSizeMake(__kWidth-20, MAXFLOAT) rowHeight:8 font:MFont(15)];
            titleLb.frame = CGRectMake(10, 0, __kWidth-20, size.height);
            titleLb.attributedText =[YGetAttribute getSpaceString:@"1.用户在确认比较申请表格后，可于48小时内查看审核结果。\n2.该服务解释权在法律规定的范围内归shopsN商城所有。" size:CGSizeMake(__kWidth-20, MAXFLOAT) rowHeight:7 font:MFont(15)];
            [cell.contentView addSubview:titleLb];
        }
        cells =  cell;
    }
    return cells;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YVIPApplyHeadSectionView *sectionV = [[YVIPApplyHeadSectionView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 50)];
    sectionV.title = _sectionArr[section];
    return sectionV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //防悬浮
    CGFloat sectionHeaderHeight = 50;
    CGFloat sectionFooterHeight = 0;
    CGFloat offsetY = tableView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableView.contentSize.height - tableView.frame.size.height - sectionFooterHeight)
    {
        tableView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableView.contentSize.height - tableView.frame.size.height - sectionFooterHeight && offsetY <= tableView.contentSize.height - tableView.frame.size.height)
    {
        tableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableView.contentSize.height - tableView.frame.size.height - sectionFooterHeight), 0);
    }

    if (indexPath.section==0) {
        CGSize size = [YGetAttribute getSpaceHeight:@"账期支付是指，符合条件的用户在审核通过后不用付款就可以进货，在确认收货后的结算日期内完成支付的交易方式。" size:CGSizeMake(__kWidth-20, MAXFLOAT) rowHeight:4 font:MFont(15)];
        return size.height+10;
    }else if (indexPath.section==1){
        return (__kWidth-40)/3+10;
    }else if (indexPath.section==2){
        return 100;
    }else if (indexPath.section==3){
        return 250;
    }else{
        CGSize size = [YGetAttribute getSpaceHeight:@"1.用户在确认比较申请表格后，可于48小时内查看审核结果。\n2.该服务解释权在法律规定的范围内归shopsN商城所有。" size:CGSizeMake(__kWidth-20, MAXFLOAT) rowHeight:8 font:MFont(17)];
        return size.height+20;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


#pragma mark ==YApplySureCellDelegate==
-(void)chooseApply{
//    [JKHttpRequestService POST:@"Pcenter/changeUserType" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
            YCustomAccountPayApplyViewController *vc = [[YCustomAccountPayApplyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//             [SXLoadingView showAlertHUD:@"您已申请过了" duration:SXLoadingTime];
//        }
//    } failure:^(NSError *error) {
//        [SXLoadingView showAlertHUD:@"您已申请过了" duration:SXLoadingTime];
//    } animated:NO];
  }

//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 50;
    CGFloat sectionFooterHeight = 0;
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
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
