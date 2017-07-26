//
//  YPersonInfoViewController.m
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonInfoViewController.h"
#import "YPersonSectionView.h"
#import "YPersonInfoCell.h"
#import "YPersonModel.h"

@interface YPersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,YPersonSectionViewDelegate,YPersonInfoCellDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) UIImageView *headIV;

/**更换头像 选择按钮标题数组 */
@property (strong,nonatomic) NSArray *titleArr;


/** 更换头像 弹出框 */
@property (strong,nonatomic) UIView *iconImageView;

/** 修改生日日期 弹出框 */
@property (strong,nonatomic) UIView *chooseDateView;

@property (strong,nonatomic) YPersonModel *model;

@property (strong,nonatomic) NSData *imageData;

@end

@implementation YPersonInfoViewController

-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    _model = [[YPersonModel alloc]init];
    [JKHttpRequestService POST:@"Pcenter/userinfo" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           NSDictionary *dic = jsonDic[@"data"];
           if (IsNull(dic)) {
               return ;
           }
           if (!IsNull(dic[@"nick_name"])) {
               strongSelf.model.nickName =dic[@"nick_name"];
           }
           if (!IsNull(dic[@"email"])) {
               strongSelf.model.email = dic[@"email"];
           }
           if (!IsNull(dic[@"sex"])) {
               strongSelf.model.sex = dic[@"sex"];
           }
           if (!IsNull(dic[@"birthday"])) {
               strongSelf.model.birth = dic[@"birthday"];
           }
           if (!IsNull(dic[@"mobile"])) {
               strongSelf.model.phone = dic[@"mobile"];
           }
           if (!IsNull(dic[@"user_name"])) {
               strongSelf.model.name = dic[@"user_name"];
           }
           [strongSelf.tableView reloadData];
       }
   } failure:^(NSError *error) {

   } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    _titleArr = @[@"我的头像",@"用户名",@"昵称",@"邮箱",@"性别",@"联系电话",@"生日"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });



}

-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 69, __kWidth, __kHeight-69)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    [self.view sendSubviewToBack:_tableView];
   

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells =nil;
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = MFont(15);
            cell.textLabel.textColor = LH_RGBCOLOR(61, 66, 69);
        }
        cell.textLabel.text = _titleArr[indexPath.row];
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-93, 8, 56, 56)];
        [cell.contentView addSubview:_headIV];
        if ([UdStorage getObjectforKey:UserHead]){
            if ([[UdStorage getObjectforKey:UserHead] isKindOfClass:[NSData class]]) {
                 _headIV.image = [UIImage imageWithData:[UdStorage getObjectforKey:UserHead]];
            }else{
                [_headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,[UdStorage getObjectforKey:UserHead]]] placeholderImage:MImage(@"user_head")];
            }
        }else{
            _headIV.image = MImage(@"user_head");
        }
        _headIV.layer.cornerRadius=28;
        _headIV.layer.masksToBounds = YES;
        cells =cell;
    }else{
        YPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPersonInfoCell"];
        if (!cell) {
            cell = [[YPersonInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPersonInfoCell"];
        }
        cell.tag = indexPath.row;
        cell.delegate = self;
        cell.title = _titleArr[indexPath.row];
        switch (indexPath.row) {
            case 1:
            {
                cell.detail = _model.name;
            }
                break;
            case 2:
            {
                cell.detail = _model.nickName;
            }
                break;
            case 3:
            {
                cell.detail = _model.email;
            }
                break;
            case 4:
            {
                cell.detail = _model.sex;
            }
                break;
            case 5:
            {
                cell.detail = _model.phone;
            }
                break;
            case 6:
            {
                cell.detail = _model.birth;
            }
                break;
            default:
                break;
        }
        cells = cell;
    }
    return cells;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    YPersonSectionView *sectionV = [[YPersonSectionView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 77)];
    sectionV.delegate = self;
    return sectionV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 72;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 77;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row==0) {
        [self changeImage];
    }


}


#pragma mark ==YPersonSectionViewDelegate==
-(void)sureChange{
    [JKHttpRequestService POST:@"Pcenter/personinfo" Params:@{@"nick_name":_model.nickName,@"email":_model.email,@"sex":_model.sex,@"birthday":_model.birth,@"app_user_id":[UdStorage getObjectforKey:Userid]} NSData:_imageData key:@"user_header" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"修改成功" duration:1.5];
        }
    } failure:^(NSError *error) {

    } animated:YES];



}
#pragma mark ==YPersonInfoCellDelegate==
-(void)changePersonInfo:(NSString *)sender index:(NSInteger)index{
    switch (index) {
//        case 1:
//        {
//            _model.name = sender;
//        }
//            break;
        case 2:
        {
            _model.nickName = sender;
        }
            break;
        case 3:
        {
            _model.email = sender;
        }
            break;
        case 4:
        {
            _model.sex = sender;
        }
            break;
//        case 5:
//        {
//            _model.phone = sender;
//        }
            break;
        case 6:
        {
            _model.birth = sender;
        }
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

//-(void)changeframe:(NSInteger)height index:(NSInteger)index{
//    NSLog(@"%ld",index);
//    if (height<100) {
//        height=258;
//    }
//    if (index*44+72+64+height+50>__kHeight) {
//        _tableView.transform =CGAffineTransformMakeTranslation(0, __kHeight-(index*44+72+64+height));
//    }
//}
//
//-(void)clearChange:(NSInteger)height index:(NSInteger)index{
//    if (index*44+72+64+height+50>__kHeight) {
//        _tableView.transform =CGAffineTransformIdentity;
//    }
//
//}

#pragma mark ===== 更换头像 =====

-(void)changeImage{
    [self.view endEditing:YES];
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
    _headIV.image = info[UIImagePickerControllerOriginalImage];
    if (picker.allowsEditing) {
        _headIV.image = info[UIImagePickerControllerEditedImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    //保存图片进入沙盒中
    [self saveImage:_headIV.image withName:@"headImage"];
}

#pragma mark - 上传头像
-(void)saveImage:(UIImage*)headImage withName:(NSString*)imageName{
    NSData *imageData = UIImageJPEGRepresentation(headImage, 0.5);

//    // 获取沙盒目录
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//
//    // 将图片保存到 document
//    [imageData writeToFile:fullPath atomically:NO];
    [UdStorage storageObject:imageData forKey:UserHead];
    _imageData = imageData;



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
