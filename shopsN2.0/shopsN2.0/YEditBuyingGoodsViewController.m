//
//  YEditBuyingGoodsViewController.m
//  shopsN
//
//  Created by imac on 2016/12/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YEditBuyingGoodsViewController.h"
#import "YBuyingGoodCell.h"
#import "YBuyingGoodInfoCell.h"
#import "YBuyingGoodPicCell.h"
#import "YBuyingGoodModel.h"

#import "YBuingGoodscheckViewController.h"

@interface YEditBuyingGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,YBuyingGoodCellDelegate,YBuyingGoodInfoCellDelegate,YBuyingGoodPicCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,YBuingGoodscheckViewControllerDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *imageArr;

@property (strong,nonatomic) YBuyingGoodModel *model;

@property (strong,nonatomic) NSArray *titleArr;

/** 弹出框 */
@property (strong,nonatomic) UIView *iconImageView;

@end

@implementation YEditBuyingGoodsViewController

-(void)getData{
   _model = [[YBuyingGoodModel alloc]init];
//    _model.goodNo = @"45486";
//    _model.goodName = @"得力660思达中性笔水笔签字笔";
//    _model.goodClass = @"桌面文具";
//    _model.goodCount = @"10箱";
//    _model.goodMoney = @"50";
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/editerpuchase" withParameters:@{@"purchase_product_id":_editId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            strongSelf.model = [YSParseTool getParseEditerPurchase:jsonDic[@"data"]];
            if (strongSelf.model.imageArr.count) {
                strongSelf.imageArr = [NSMutableArray arrayWithArray:weakSelf.model.imageArr];
            }
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑采购商品";
    _imageArr = [NSMutableArray array];
    [self getData];
    _titleArr = @[@"商品编号：",@"商品名称：",@"商品分类：",@"所需数量：",@"预算单价："];
    [self.rightBtn setImage:MImage(@"cart_delete") forState:BtnNormal];
    [self initView];
}
-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-45)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor =  [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view sendSubviewToBack:_tableV];

    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV), __kWidth-20, 44)];
    [self.view addSubview:saveBtn];
    saveBtn.backgroundColor = LH_RGBCOLOR(224, 40, 40);
    saveBtn.layer.cornerRadius = 5;
    saveBtn.titleLabel.font = MFont(16);
    [saveBtn setTitle:@"保存" forState:BtnNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [saveBtn addTarget:self action:@selector(chooseSave) forControlEvents:BtnTouchUpInside];
}
#pragma mark ==删除==
- (void)chooseRight{
    NSLog(@"删除");
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/purchasede" withParameters:@{@"purchase_product_id":_model.goodID,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"删除成功" duration:SXLoadingTime];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

#pragma mark ==保存==
- (void)chooseSave{
    NSLog(@"保存");
    if ([_model.goodMoney containsString:@"¥"]) {
        _model.goodMoney=[_model.goodMoney stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    }
    if (IsNilString(_purchaseId)) {
        _purchaseId= @"";
    }
//    NSMutableArray *datas = [NSMutableArray array];
//    if (_imageArr.count) {
//        for (id obj in _imageArr) {
//            NSData *imageData;
//            if ([obj isKindOfClass:[NSString class]]) {
//                UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,obj]]]];
//                imageData = UIImageJPEGRepresentation(image, 0.5);
//            }else{
//                imageData =  UIImageJPEGRepresentation(obj, 0.5);
//            }
//            [datas addObject:imageData];
//        }
//    }
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/newPurchase" Params:@{@"purchase_id":_purchaseId,@"product_sn":_model.goodNo,@"productname":_model.goodName,@"productclass":_model.goodClass,@"productnum":_model.goodCount,@"productbudget":_model.goodMoney,@"productexplain":_model.goodInfo,@"purchase_product_id":_model.goodID,@"app_user_id":[UdStorage getObjectforKey:Userid]} NSArray:_imageArr key:@"productimg" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"修改成功" duration:SXLoadingTime];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.row==5) {
        YBuyingGoodInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingGoodInfoCell"];
        if (!cell) {
            cell = [[YBuyingGoodInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingGoodInfoCell"];
        }
        cell.warn = @"请输入说明";
        cell.delegate = self;
        cell.info = _model.goodInfo;
        cells = cell;
    }else if (indexPath.row==6){
        YBuyingGoodPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingGoodPicCell"];
        if (!cell) {
            cell = [[YBuyingGoodPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingGoodPicCell"];
        }
        cell.imageArr=_imageArr;
        cell.delegate = self;
        cells = cell;
    }else{
        YBuyingGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingGoodCell"];
        if (!cell) {
            cell = [[YBuyingGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingGoodCell"];
        }
        cell.tag = indexPath.row;
        cell.title = _titleArr[indexPath.row];
        if (indexPath.row==0||indexPath.row==4) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row==4) {
            cell.isMoney = YES;
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.detail = _model.goodNo;
            }
                break;
            case 1:
            {
                cell.detail = _model.goodName;
            }
                break;
            case 2:
            {
                cell.detail = _model.goodClass;
            }
                break;
            case 3:
            {
                cell.detail = _model.goodCount;
            }
                break;
            case 4:
            {
                cell.detail = _model.goodMoney;
            }
                break;
            default:
                break;
        }
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==5) {
        return 134;
    }else if (indexPath.row==6){
        return 150;
    }else{
        return 50;
    }
}

#pragma mark ==YBuyingGoodCellDelegate==
-(void)getDetailtext:(NSString *)sender Index:(NSInteger)tag{
    NSLog(@"%@ %ld",sender,tag);
    switch (tag) {
//        case 0:
//        {
//            _model.goodNo = sender;
//        }
//            break;
//        case 1:
//        {
//            _model.goodName = sender;
//        }
//            break;
//        case 2:
//        {
//            _model.goodClass = sender;
//        }
//            break;
        case 3:
        {
            _model.goodCount = sender;
        }
            break;
        case 4:
        {
            _model.goodMoney = sender;
        }
            break;
        default:
            break;
    }
}

-(void)choosedata{
    YBuingGoodscheckViewController *vc = [[YBuingGoodscheckViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YBuyingGoodInfoCellDelegate==
-(void)getInfoDetail:(NSString *)sender{
    NSLog(@"%@",sender);
    _model.goodInfo = sender;
}


#pragma mark ==YBuyingGoodPicCellDelegate==
-(void)addPhotos{
    NSLog(@"添加图片");
    [self addImage];
}

-(void)deletePicIndex:(NSInteger)sender{
    NSLog(@"删除图片");
    [_imageArr removeObjectAtIndex:sender];
    [_tableV reloadData];
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
        //        btn.backgroundColor = HEXCOLOR(0xf1f1f1);
        [btn setTitleColor:HEXCOLOR(0x0051ff) forState:BtnNormal];
        //        btn.titleLabel.font = MFont(15);
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

#pragma mark - 更换头像Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *goodImage  = info[UIImagePickerControllerOriginalImage];
    if (picker.allowsEditing) {
        goodImage = info[UIImagePickerControllerEditedImage];
    }
    [_imageArr addObject:goodImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //保存图片进入沙盒中
    [_tableV reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self checkImageType];
    });
}

- (void)checkImageType{
    NSMutableArray *datas = [NSMutableArray array];
    if (_imageArr.count) {
        for (id obj in _imageArr) {
            NSData *imageData;
            if ([obj isKindOfClass:[NSString class]]) {
                UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,obj]]]];
                imageData = UIImageJPEGRepresentation(image, 0.5);
            }else{
                imageData =  UIImageJPEGRepresentation(obj, 0.5);
            }
            [datas addObject:imageData];
        }
    }
    _imageArr = datas;

}


#pragma mark ==YBuingGoodscheckViewControllerDelegate==
-(void)chooseGood:(YBuyingGoodModel *)data{
    _model.goodNo = data.goodNo;
    _model.goodName = data.goodName;
    _model.goodClass = data.goodClass;
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
