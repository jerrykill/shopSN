//
//  YFoundPasswordViewController.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFoundPasswordViewController.h"
#import "YFoundEmailViewController.h"
#import "YResetPassViewController.h"

@interface YFoundPasswordViewController ()<UITextFieldDelegate>

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) NSString *mobile;

@property (strong,nonatomic) NSString *code;

@property (strong,nonatomic) NSString *picCode;

@property (strong,nonatomic) UIImageView *numIV;
@end

@implementation YFoundPasswordViewController


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
    [self initView];
    [self getNavis];
}

-(void)getNavis{
    UIView *NaviV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:NaviV];
    NaviV.backgroundColor = [UIColor whiteColor];
    [self.view bringSubviewToFront:NaviV];

    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 29, 30, 25)];
    [NaviV addSubview:cancelBtn];
    cancelBtn.titleLabel.font = MFont(14);
    [cancelBtn setTitle:@"返回" forState:BtnNormal];
    [cancelBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-120)/2, 32, 120, 20)];
    [NaviV addSubview:titleLb];
    titleLb.textAlignment =NSTextAlignmentCenter;
    titleLb.font = BFont(16);
    titleLb.textColor = __DTextColor;
    titleLb.text = @"找回密码";
}


-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 1)];
    [self.view addSubview:lineIV];
    lineIV.backgroundColor = HEXCOLOR(0xcbcbcb);

    _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 65, __kWidth, __kHeight-65)];
    [self.view addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];

    NSArray *imageArr = @[@"login_phone",@"login_SMS",@"login_verification"];
    for (int i=0; i<3; i++) {
        UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(30, 20+70*i, __kWidth-60, 56)];
        [_backV addSubview:putV];
        putV.backgroundColor =LH_RGBCOLOR(245, 245, 245);
        putV.layer.cornerRadius = 5;

        UIImageView *headIV = [[UIImageView alloc]init];
        [putV addSubview:headIV];
        headIV.image= MImage(imageArr[i]);

        UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(60, 18, __kWidth-210, 20)];
        [putV addSubview:inputTF];
        inputTF.font = MFont(14);
        inputTF.tag = i+33;
        inputTF.delegate = self;
        inputTF.textAlignment = NSTextAlignmentLeft;

        switch (i) {
            case 0:
            {
                headIV.frame = CGRectMake(19, 16, 19, 26);
                inputTF.placeholder = @"已验证手机";
            }
                break;
            case 1:
            {
                headIV.frame = CGRectMake(18, 20, 22, 17);
                UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-150, 1.5, 90, 53)];
                [putV addSubview:codeBtn];
                codeBtn.titleLabel.font = MFont(15);
                codeBtn.layer.cornerRadius =5;
                codeBtn.backgroundColor = [UIColor whiteColor];
                [codeBtn setTitle:@"获取验证码" forState:BtnNormal];
                [codeBtn setTitleColor:__TextColor forState:BtnNormal];
                [codeBtn addTarget:self action:@selector(getCode) forControlEvents:BtnTouchUpInside];
                inputTF.placeholder = @"短信验证码";
            }
                break;
            case 2:
            {
                putV.frame = CGRectMake(30, 20+70*i, __kWidth-190, 56);
                headIV.frame = CGRectMake(17, 17, 23, 24);
                inputTF.frame = CGRectMake(60, 18, __kWidth-250, 20);
                inputTF.placeholder = @"图片验证码";

                _numIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(putV)+5, 172, 81, 32)];
                [_backV addSubview:_numIV];
                _numIV.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.yisu.cn/Home/Register/verify"]]];

                UIButton *changeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_numIV), 172, 50, 32)];
                [_backV addSubview:changeBtn];
                changeBtn.titleLabel.font = MFont(14);
                [changeBtn setTitle:@"换一张" forState:BtnNormal];
                [changeBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
                [changeBtn addTarget:self action:@selector(change) forControlEvents:BtnTouchUpInside];
            }
                break;

            default:
                break;
        }
    }
    UIButton *foundBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 249, __kWidth-60, 56)];
    [_backV addSubview:foundBtn];
    foundBtn.layer.cornerRadius =28;
    foundBtn.backgroundColor = __DefaultColor;
    foundBtn.titleLabel.font = BFont(18);
    [foundBtn setTitle:@"找回密码" forState:BtnNormal];
    [foundBtn addTarget:self action:@selector(found) forControlEvents:BtnTouchUpInside];


}

#pragma mark ==获取验证码==
-(void)getCode{
    NSLog(@"获取验证码");
    [self.view endEditing:YES];
    if (!IsNilString(_mobile)) {
        [JKHttpRequestService POST:@"Register/short_message_send" withParameters:@{@"mobile":_mobile} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                [SXLoadingView showAlertHUD:@"发送成功" duration:1];
            }
        } failure:^(NSError *error) {
            
        } animated:YES];
    }

}
#pragma mark ==换一张==
-(void)change{
    NSLog(@"换一张图");
   _numIV.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.yisu.cn/Home/Register/verify"]]];
}
#pragma mark ==找回密码==
-(void)found{
    NSLog(@"找回密码");
    [JKHttpRequestService POST:@"Register/find_pwd" withParameters:@{@"mobile":_mobile,@"verify":_picCode,@"code":_code} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [UdStorage storageObject:jsonDic[@"data"] forKey:Userid];
            YResetPassViewController *vc =[[YResetPassViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}

//#pragma mark ==邮箱找回密码==
//-(void)chooseEmail{
//    NSLog(@"邮箱找回");
//    YFoundEmailViewController *vc = [[YFoundEmailViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    switch (textField.tag-33) {
        case 0:
        {
            _mobile = textField.text;
        }
            break;
        case 1:
        {
            _code = textField.text;
        }
            break;
        case 2:
        {
            _picCode = textField.text;
        }
            break;
        default:
            break;
    }
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleDefault;
}

- (void)dealloc {
    _numIV =nil;
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
