//
//  YApplyDrawbackViewController.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyDrawbackViewController.h"
#import "YDrawBackOrderHeadView.h"
#import "YDrawBackGoodCell.h"
#import "YDrawBackMoneyCell.h"
#import "YDrawBackInputCell.h"
#import "YOrdersDetailCountCell.h"
#import "YApplySalesModel.h"

@interface YApplyDrawbackViewController ()<UITableViewDelegate,UITableViewDataSource,YDrawBackInputCellDelegate,YDrawBackMoneyCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong,nonatomic) UITableView *mainV;

//@property (strong,nonatomic) NSMutableArray *imageArr;

@property (nonatomic) BOOL show;

/** 弹出框 */
@property (strong,nonatomic) UIView *iconImageView;

@property (assign,nonatomic) CGFloat inputHeight;

@property (strong,nonatomic) YApplySalesModel *applyData;

@end

@implementation YApplyDrawbackViewController

- (void)getData{
//    _imageArr = [NSMutableArray array];
    _applyData = [[YApplySalesModel alloc]init];
    _applyData.orderId = _order.orderId;
    _applyData.goodArr = [NSMutableArray array];
//    _goodArr = [NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        YOrderGoodModel *model = [[YOrderGoodModel alloc]init];
//        model.goodName = @"齐心 B2174 经济型资料架/文件框 四格齐心B2174 经济型资料架/文件框 四格";
//        model.num = @"1";
//        model.goodUrl = @"";
//        [_goodArr addObject:model];
//    }

    [_mainV reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    [self getData];
    [self initView];
}

-(void)initView{
    _mainV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-77)];
    [self.view addSubview:_mainV];
    _mainV.backgroundColor = __BackColor;
    _mainV.separatorColor = [UIColor clearColor];
    _mainV.delegate = self;
    _mainV.dataSource = self;
    [self.view sendSubviewToBack:_mainV];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(_mainV), __kWidth, 77)];
    [self.view addSubview:bottomV];
    bottomV.backgroundColor = [UIColor whiteColor];

    UIButton *surePutBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 18, __kWidth-20, 45)];
    [bottomV addSubview:surePutBtn];
    surePutBtn.backgroundColor = __DefaultColor;
    surePutBtn.layer.cornerRadius = 4;
    surePutBtn.titleLabel.font = MFont(16);
    [surePutBtn setTitle:@"确认申请" forState:BtnNormal];
    [surePutBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [surePutBtn addTarget:self action:@selector(choosePut) forControlEvents:BtnTouchUpInside];


}

#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_goodArr.count<4) {
        return _goodArr.count+2;
    }else{
       if (_show) {
          return _goodArr.count+3;
       }else{
          return 6;
       }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (_goodArr.count<=3) {//商品种类小于3
        if (indexPath.row<_goodArr.count) {
            YDrawBackGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackGoodCell"];
            if (!cell) {
                cell = [[YDrawBackGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackGoodCell"];
            }
//            YOrderGoodModel *model = _goodArr[indexPath.row];
            YShopGoodModel *model = _goodArr[indexPath.row];
            cell.model = model ;
            cells = cell;
        }else if (indexPath.row==_goodArr.count){
            YDrawBackMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackMoneyCell"];
            if (!cell) {
                cell = [[YDrawBackMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackMoneyCell"];
            }
            cell.money =  _order.payMoney;
            cell.applyMoney = _applyData.price;
            cell.fright = _order.freight;
            cell.delegate = self;
            cells =  cell;
        }else{
            YDrawBackInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackInputCell"];
            if (!cell) {
                cell = [[YDrawBackInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackInputCell"];
            }
            cell.delegate = self;
            cell.imageArr = _applyData.goodArr;
            cells = cell;
        }
    }else{
        if (_show) {//商品种类大于3且展开
           if (indexPath.row<_goodArr.count) {
                YDrawBackGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackGoodCell"];
                if (!cell) {
                    cell = [[YDrawBackGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackGoodCell"];
                }
                YShopGoodModel *model = _goodArr[indexPath.row];
                cell.model = model ;
                cells = cell;
           }else if (indexPath.row==_goodArr.count){
               YOrdersDetailCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailCountCell"];
               if (!cell) {
                   cell = [[YOrdersDetailCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailCountCell"];
               }
               cell.count = [NSString stringWithFormat:@"%ld",(_goodArr.count-3)];
               cell.show=_show;
               cells=cell;
           }else if (indexPath.row==_goodArr.count+1){
                YDrawBackMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackMoneyCell"];
                if (!cell) {
                    cell = [[YDrawBackMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackMoneyCell"];
                }
                cell.money =  _order.payMoney;
               cell.applyMoney = _applyData.price;
                cell.fright = _order.freight;
                cell.delegate = self;
                cells =  cell;
            }else{
                YDrawBackInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackInputCell"];
                if (!cell) {
                    cell = [[YDrawBackInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackInputCell"];
                }
                cell.delegate = self;
                cell.imageArr =  _applyData.goodArr;
                cells = cell;
            }
        }else{//商品种类大于3 合上
            if (indexPath.row<3) {
                YDrawBackGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackGoodCell"];
                if (!cell) {
                    cell = [[YDrawBackGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackGoodCell"];
                }
                YOrderGoodModel *model = _goodArr[indexPath.row];
                cell.model = model ;
                cells = cell;
            }else if (indexPath.row==3){
                YOrdersDetailCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrdersDetailCountCell"];
                if (!cell) {
                    cell = [[YOrdersDetailCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrdersDetailCountCell"];
                }
                cell.count = [NSString stringWithFormat:@"%ld",(_goodArr.count-3)];
                cell.show=_show;
                cells=cell;
            }else if (indexPath.row==4){
                YDrawBackMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackMoneyCell"];
                if (!cell) {
                    cell = [[YDrawBackMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackMoneyCell"];
                }
                cell.money =  _order.payMoney;
                cell.applyMoney = _applyData.price;
                cell.fright = _order.freight;
                cell.delegate = self;
                cells =  cell;
            }else{
                YDrawBackInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDrawBackInputCell"];
                if (!cell) {
                    cell = [[YDrawBackInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDrawBackInputCell"];
                }
                cell.delegate = self;
                cell.imageArr =  _applyData.goodArr;
                cells = cell;
            }
        }
    }
       return cells;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YDrawBackOrderHeadView *header = [[YDrawBackOrderHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 66)];
    header.orderId = _order.orderId;
    header.orderTime = _order.createTime;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_goodArr.count<4) {
        _inputHeight = 107*_goodArr.count+66+105;
        if (indexPath.row<_goodArr.count) {
            return 107;
        }else if (indexPath.row==_goodArr.count){
            return 147;
        }else{
            return 225;
        }
    }else{
        if (_show) {
            _inputHeight = 107*_goodArr.count+40+66+105;
            if (indexPath.row<_goodArr.count) {
                return 107;
            }else if (indexPath.row==_goodArr.count){
                return 40;
            }else if (indexPath.row==_goodArr.count+1){
                return 147;
            }else{
                return 225;
            }

        }else{
            _inputHeight = 107*3+66+40+105;
            if (indexPath.row<3) {
                return 107;
            }else if (indexPath.row==3){
                return 40;
            }else if (indexPath.row==4){
                return 147;
            }else{
                return 225;
            }
        }

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 66;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_goodArr.count>3) {
        if (indexPath.row==3&&!_show) {
            _show = !_show;
            [_mainV reloadData];
        }else if (indexPath.row==_goodArr.count){
            _show =!_show;
            [_mainV reloadData];
        }
    }
}



#pragma mark ==YDrawBackInputCellDelegate==
-(void)addPhotos{
    NSLog(@"添加图片");
    [self addImage];
}

-(void)deletePicIndex:(NSInteger)index{
    NSLog(@"删除图片");
    [_applyData.goodArr removeObjectAtIndex:index];
    [_mainV reloadData];
}
-(void)getInputText:(NSString *)text{
    NSLog(@"申请理由：%@",text);
    _applyData.info = text;
}

#pragma mark ==YDrawBackMoneyCellDelegate==
-(void)getApplyMoney:(NSString *)money{
    NSLog(@"申请金额：%@",money);
    _applyData.price = money;

}

#pragma mark ==确认申请==
-(void)choosePut{
    NSLog(@"确认提交");
    if ([self checkNull]) {
        [JKHttpRequestService POST:@"Order/RefundSubmit" Params:@{@"order_id":_applyData.orderId,@"price":_applyData.price,@"number":_applyData.num,@"case":_applyData.info,@"app_user_id":[UdStorage getObjectforKey:Userid]} NSArray:_applyData.goodArr key:@"refund" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                [SXLoadingView showAlertHUD:@"申请成功" duration:SXLoadingTime];
                NSArray *arr = @[@"1"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderData" object:arr];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    }

}

- (BOOL)checkNull {
    if (IsNilString(_applyData.price)) {
        _applyData.price = @"0.00";
    }
    if (IsNilString(_applyData.info)) {
        [SXLoadingView showAlertHUD:@"请说明原因" duration:SXLoadingTime];
        return NO;
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
     NSData *imageData = UIImageJPEGRepresentation(goodImage, 0.5);
    [_applyData.goodArr addObject:imageData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //保存图片进入沙盒中
    [_mainV reloadData];
}

//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 66;
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
