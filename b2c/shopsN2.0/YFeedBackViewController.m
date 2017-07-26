//
//  YFeedBackViewController.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFeedBackViewController.h"
#import "YfeedBackOneCell.h"
#import "YfeedBackTwoCell.h"
#import "YfeedBackThreeCell.h"
#import "YFeedbackChooseView.h"

@interface YFeedBackViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,YfeedBackOneCellDelegate,YFeedbackChooseViewDelegate,YfeedBackTwoCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) UITextView *detailTF;

@property (strong,nonatomic) NSString *connects;

@property (strong,nonatomic) NSString *type;

@property (strong,nonatomic) NSArray *typeArr;

@end

@implementation YFeedBackViewController

-(void)putData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/feedback" withParameters:@{@"type":_type,@"tel":_connects,@"content":_detailTF.text,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:jsonDic[@"msg"] duration:SXLoadingTime];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeArr = @[@"功能意见",@"页面意见",@"你的新需求",@"操作意见",@"流量问题",@"其他"];
    self.title = @"意见反馈";
    self.rightBtn.hidden = YES;
    [self initView];
}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 320)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.scrollEnabled = NO;

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV)+10, __kWidth-20, 44)];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.backgroundColor = __DefaultColor;
    sureBtn.titleLabel.font = MFont(15);
    [sureBtn setTitle:@"确认提交" forState:BtnNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [sureBtn addTarget:self action:@selector(putMessage) forControlEvents:BtnTouchUpInside];

}
#pragma mark ==UITableView==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells= nil;
    if (indexPath.row==0) {
        YfeedBackOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YfeedBackOneCell"];
        if (!cell) {
            cell = [[YfeedBackOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YfeedBackOneCell"];
        }
        if (!IsNilString(_type)) {
            cell.type= _typeArr[[_type integerValue]-1];
        }
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.row == 1){
        YfeedBackTwoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"YfeedBackTwoCell"];
        if (!cell) {
            cell = [[YfeedBackTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YfeedBackTwoCell"];
        }
        if (!IsNilString(_connects)) {
            cell.connectTF.text =_connects;
        }
        cell.delegate = self;
        cells = cell;
    }else{
        YfeedBackThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YfeedBackThreeCell"];
        if (!cell) {
            cell = [[YfeedBackThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YfeedBackThreeCell"];
        }
        _detailTF = cell.detailTV;
        cells = cell;

    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2) {
        return 220;
    }else{
        return 50;
    }
}



#pragma mark ==提交意见==
-(void)putMessage{
    NSLog(@"确认提交");
    [self.view endEditing:YES];
    if (IsNilString(_detailTF.text)||IsNilString(_connects)||IsNilString(_type)) {
        [SXLoadingView showAlertHUD:@"信息不全" duration:SXLoadingTime];
    }
    [self putData];
}


#pragma mark ==YfeedBackOneCellDelegate==
-(void)choosefeedType{
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[YFeedbackChooseView class]]) {
            [obj removeFromSuperview];
        }
    }
    YFeedbackChooseView *chooseV = [[YFeedbackChooseView alloc]initWithFrame:CGRectMake(0, __kHeight-223, __kWidth, 223)];
    [self.view addSubview:chooseV];
    chooseV.typeArr = @[@"功能意见",@"页面意见",@"你的新需求",@"操作意见",@"流量问题",@"其他"];
    chooseV.delegate = self;
}
#pragma mark ==YFeedbackChooseViewDelegate==
-(void)chooseFeedType:(NSString *)type{
    _type =type;
    [_tableV reloadData];
}

#pragma mark ==YfeedBackTwoCellDelegate==
-(void)connectWay:(NSString *)sender{
    _connects = sender;
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
