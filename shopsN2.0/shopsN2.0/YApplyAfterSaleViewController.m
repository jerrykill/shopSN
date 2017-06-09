//
//  YApplyAfterSaleViewController.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyAfterSaleViewController.h"
#import "YApplyAfterSalesCell.h"
#import "YChooseSalesServiceCell.h"
#import "YReturnsNumCell.h"
#import "YDrawBackMoneyCell.h"
#import "YDrawBackInputCell.h"
#import "YApplySalesSureCell.h"
#import "YApplySalesModel.h"

@interface YApplyAfterSaleViewController ()<YChooseSalesServiceCellDelegate,YReturnsNumCellDelegate,UITableViewDelegate,UITableViewDataSource,YDrawBackInputCellDelegate,YDrawBackMoneyCellDelegate,YApplySalesSureCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (strong,nonatomic) UITableView *tableV;



@property (strong,nonatomic) YApplySalesModel *applyData;

/** 弹出框 */
@property (strong,nonatomic) UIView *iconImageView;

@end

@implementation YApplyAfterSaleViewController

- (void)getdata {

}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"申请售后";
    _applyData = [[YApplySalesModel alloc]init];
    _applyData.goodArr = [NSMutableArray array];
    _applyData.num = @"1";
    _applyData.orderId = _model.orderId;
    YReturnsGoodModel *good = _model.list.firstObject;
    _applyData.goodId = good.goodId;
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view sendSubviewToBack:_tableV];

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells =nil;
    if (indexPath.row==0) {
        YApplyAfterSalesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplyAfterSalesCell"];
        if (!cell) {
            cell = [[YApplyAfterSalesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplyAfterSalesCell"];
        }
        cell.model = _model;
        cells = cell;
    }else if (indexPath.row==1){
        YChooseSalesServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YChooseSalesServiceCell"];
        if (!cell) {
            cell = [[YChooseSalesServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YChooseSalesServiceCell"];
        }
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.row==2){
        YDrawBackMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackMoneyCell"];
        if (!cell) {
            cell = [[YDrawBackMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackMoneyCell"];
        }
        YReturnsGoodModel *good = _model.list.firstObject;
        cell.money= [NSString stringWithFormat:@"%.2f",[good.applyMoney floatValue]*[good.num integerValue]];
        cell.fright = @"0.00";
        if (!IsNilString(_applyData.price)) {
            cell.applyMoney = _applyData.price;
        }
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.row==3){
        YReturnsNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YReturnsNumCell"];
        if (!cell) {
            cell = [[YReturnsNumCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YReturnsNumCell"];
        }
        YReturnsGoodModel *good = _model.list.firstObject;
        cell.count = good.num;
        cell.delegate = self;
        cells = cell;
    }else if(indexPath.row==4) {
        YDrawBackInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackInputCell"];
        if (!cell) {
            cell = [[YDrawBackInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackInputCell"];
        }
        cell.imageArr = _applyData.goodArr;
        cell.delegate = self;
        cells = cell;
    }else{
        YApplySalesSureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplySalesSureCell"];
        if (!cell) {
            cell = [[YApplySalesSureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplySalesSureCell"];
        }
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 180;
    }else if (indexPath.row==1){
        return 125;
    }else if (indexPath.row==2){
        return 147;
    }else if (indexPath.row==3){
        return 135;
    }else if (indexPath.row==4){
        return 225;
    }else{
        return 85;
    }
}

#pragma mark ==YChooseSalesServiceCellDelegate==
-(void)chooseServiceType:(NSInteger)sender{
    switch (sender) {
        case 0:
            NSLog(@"退货");
            _applyData.type = @"1";
            break;
        case 1:
            NSLog(@"换货");
            _applyData.type = @"0";
            break;
        case 2:
            NSLog(@"维修");
            _applyData.type = @"3";
            break;
        default:
            break;
    }
}

#pragma mark ==YDrawBackMoneyCellDelegate==
-(void)getApplyMoney:(NSString *)money{
    NSLog(@"%@",money);
    _applyData.price= money;
}

#pragma mark ==YReturnsNumCellDelegate==
-(void)changeApplyNum:(BOOL)sender{
    NSInteger count = [_applyData.num integerValue];
    if (sender) {
        count++;
    }else{
        count--;
    }
    _applyData.num = [NSString stringWithFormat:@"%ld",count];
    NSLog(@"%@",_applyData.num);
}

#pragma mark ==YDrawBackInputCellDelegate==
-(void)addPhotos{
    NSLog(@"添加图片");
    [self addImage];
}

-(void)deletePicIndex:(NSInteger)index{
    NSLog(@"删除图片");
    [_applyData.goodArr removeObjectAtIndex:index];
    [_tableV reloadData];
}
-(void)getInputText:(NSString *)text{
    NSLog(@"申请理由：%@",text);
    _applyData.info = text;
}


#pragma mark ==YApplySalesSureCellDelegate==
-(void)makeAppply{
    NSLog(@"申请");
    if ([self checkNull]) {
    [JKHttpRequestService POST:@"Pcenter/afterSaleApply" Params:@{@"order_id":_applyData.orderId,@"goods_id":_applyData.goodId,@"type":_applyData.type,@"price":_applyData.price,@"number":_applyData.num,@"explain":_applyData.info,@"app_user_id":[UdStorage getObjectforKey:Userid]} NSArray:_applyData.goodArr key:@"pic_url" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"申请成功" duration:SXLoadingTime];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
    }
}

- (BOOL)checkNull {
    if (IsNilString(_applyData.info)) {
        [SXLoadingView showAlertHUD:@"请描述原因" duration:SXLoadingTime];
        return NO;
    }
    if (IsNilString(_applyData.type)) {
        [SXLoadingView showAlertHUD:@"请选择类型" duration:SXLoadingTime];
        return NO;
    }
    if (IsNilString(_applyData.price)) {
        _applyData.price = @"0.00";
    }
    return YES;
}

#pragma mark ===== 添加图片 =====
-(void)addImage{
    //弹出框
    _iconImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    _iconImageView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    [self.view addSubview:_iconImageView];
    //*** 按设计修改后内容
    NSArray *array = @[@"拍照", @"我的相册", @"取消"];
    //1 菜单视图 选择拍照或相册
    UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(10, __kHeight-172, __kWidth-20, 102)];
    chooseView.backgroundColor = HEXCOLOR(0xffffff);
    [_iconImageView addSubview:chooseView];
    chooseView.layer.cornerRadius = 10.0f;

    //1.1 中间分隔线
    UIImageView *lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, CGRectW(chooseView), 1)];
    [chooseView addSubview:lineIV];
    lineIV.backgroundColor = HEXCOLOR(0xdedede);

    //1.2 选择拍照或相册 按钮
    //    按钮颜色 color(0 84 255)  (0x0051ff)
    for (NSInteger i=0; i<array.count-1; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*52, CGRectW(chooseView), 50)];
        [btn setTitleColor:HEXCOLOR(0x0051ff) forState:BtnNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(iconBtnAction:) forControlEvents:BtnTouchUpInside];
        btn.tag = 160+i;
        [chooseView addSubview:btn];
    }


    //2 菜单视图 选择 取消
    UIView *cancelView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectYH(chooseView)+10, __kWidth-20, 50)];
    cancelView.backgroundColor = HEXCOLOR(0xffffff);
    [_iconImageView addSubview:cancelView];
    cancelView.layer.cornerRadius = 10.0f;

    //2.1 按钮
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectW(cancelView), 50)];
    [cancelView addSubview:cancelBtn];
    [cancelBtn setTitleColor:HEXCOLOR(0x0051ff) forState:BtnNormal];
    //  cancelBtn.titleLabel.font = MFont(15);
    [cancelBtn setTitle:array[2] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(iconBtnAction:) forControlEvents:BtnTouchUpInside];
    cancelBtn.tag = 162;



}

- (void)iconBtnAction:(UIButton *)btn {
    switch (btn.tag - 160) {
        case 0: {
            NSLog(@"拍照");
            UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
            pickerVC.delegate = self;
            //选择照片数据源 ---默认是相册
            pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerVC animated:YES completion:nil];
        }


            break;
        case 1: {
            NSLog(@"从相册获取");
            UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
            //想要知道选择的图片
            pickerVC.delegate = self;
            //开启编辑状态
            pickerVC.allowsEditing = YES;
            [self presentViewController:pickerVC animated:YES completion:nil];
            [_iconImageView removeFromSuperview];
        }

            break;
        default:
            NSLog(@"取消");
            [_iconImageView removeFromSuperview];
            break;
    }
}

#pragma mark - 选择图片Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *goodImage  = info[UIImagePickerControllerOriginalImage];
    if (picker.allowsEditing) {
        goodImage = info[UIImagePickerControllerEditedImage];
    }
    NSData *imageData = UIImageJPEGRepresentation(goodImage, 0.5);
    [_applyData.goodArr addObject:imageData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //保存图片进入沙盒中
    [_tableV reloadData];
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
