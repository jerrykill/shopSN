//
//  YnoteLoginViewController.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YnoteLoginViewController.h"
#import "YshareChooseView.h"
#import "YRegisterViewController.h"

@interface YnoteLoginViewController ()<UITextFieldDelegate,YshareChooseViewDelegate>

@property (strong,nonatomic) UIScrollView *backV;

@property (strong,nonatomic) NSString *mobile;

@property (strong,nonatomic) NSString *verify;

@end

@implementation YnoteLoginViewController

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
    [cancelBtn setTitle:@"取消" forState:BtnNormal];
    [cancelBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-120)/2, 32, 120, 20)];
    [NaviV addSubview:titleLb];
    titleLb.textAlignment =NSTextAlignmentCenter;
    titleLb.font = BFont(16);
    titleLb.textColor = __DTextColor;
    titleLb.text = [NSString stringWithFormat:@"%@短信验证",ShortTitle];
}

- (void)initView{
    _backV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self.view addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];
    [self.view sendSubviewToBack:_backV];
    _backV.contentSize = CGSizeMake(__kWidth, 606);

    //main
    UIImageView *loginIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-221)/2, 95, 221, 49)];
    [_backV addSubview:loginIV];
    loginIV.image =MImage(@"loginLogo");
    loginIV.contentMode = UIViewContentModeScaleAspectFit;

    NSArray *imageArr = @[@"login_phone",@"login_SMS"];
    for (int i=0; i<2; i++) {
        UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(30, 30+CGRectYH(loginIV)+70*i, __kWidth-60, 56)];
        [_backV addSubview:putV];
        putV.backgroundColor = LH_RGBCOLOR(245, 245, 245);
        putV.layer.cornerRadius = 5;

        UIImageView *headIV = [[UIImageView alloc]init];
        [putV addSubview:headIV];
        headIV.image = MImage(imageArr[i]);

        UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(60, 18, __kWidth-180, 20)];
        [putV addSubview:inputTF];
        inputTF.font = MFont(14);
        inputTF.tag = i;
        inputTF.delegate = self;
        inputTF.textAlignment = NSTextAlignmentLeft;
        if (!i) {
            headIV.frame = CGRectMake(19, 16, 19, 26);
            inputTF.placeholder = @"请输入验证手机";
        }else{
             headIV.frame = CGRectMake(18, 20, 22, 17);
            UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-145, 1.5, 85, 53)];
            [putV addSubview:codeBtn];
            codeBtn.titleLabel.font = MFont(15);
            codeBtn.layer.cornerRadius =5;
            codeBtn.backgroundColor = [UIColor whiteColor];
            [codeBtn setTitle:@"获取验证码" forState:BtnNormal];
            [codeBtn setTitleColor:__TextColor forState:BtnNormal];
            [codeBtn addTarget:self action:@selector(getCode) forControlEvents:BtnTouchUpInside];
            inputTF.placeholder = @"请输入短信验证码...";
        }
    }

    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectYH(loginIV)+200, __kWidth-60, 56)];
    [_backV addSubview:loginBtn];
    loginBtn.backgroundColor = __DefaultColor;
    loginBtn.layer.cornerRadius = 28;
    loginBtn.titleLabel.font = MFont(18);
    [loginBtn setTitle:@"登录" forState:BtnNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [loginBtn addTarget:self action:@selector(Login) forControlEvents:BtnTouchUpInside];

//    UIButton *ViploginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectYH(loginBtn)+5, __kWidth-60, 56)];
//    [_backV addSubview:ViploginBtn];
//    ViploginBtn.backgroundColor = [UIColor whiteColor];
//    ViploginBtn.layer.cornerRadius = 28;
//    ViploginBtn.titleLabel.font = MFont(16);
//    ViploginBtn.layer.borderColor =__BackColor.CGColor;
//    ViploginBtn.layer.borderWidth = 1;
//    [ViploginBtn setTitle:@"VIP合约客户登录" forState:BtnNormal];
//    [ViploginBtn setTitleColor:__TextColor forState:BtnNormal];
//    [ViploginBtn addTarget:self action:@selector(Login) forControlEvents:BtnTouchUpInside];
//    [ViploginBtn setImage:MImage(@"login_vip") forState:BtnNormal];
//    ViploginBtn.imageEdgeInsets = UIEdgeInsetsMake(18, 0, 18, 10);
//    ViploginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    UIButton *cannotBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectYH(loginBtn)+10, (__kWidth-80)/2, 20)];
    [_backV addSubview:cannotBtn];
    cannotBtn.titleLabel.font = MFont(15);
    cannotBtn.backgroundColor = [UIColor clearColor];
    [cannotBtn setTitle:@"账户登录" forState:BtnNormal];
    [cannotBtn setTitleColor:__TextColor forState:BtnNormal];
    [cannotBtn addTarget:self action:@selector(cannotLogin) forControlEvents:BtnTouchUpInside];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-2)/2, CGRectYH(loginBtn)+15, 2, 14)];
    [_backV addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    UIButton *logonBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth/2+20, CGRectYH(loginBtn)+10, (__kWidth-80)/2, 20)];
    [_backV addSubview:logonBtn];
    logonBtn .titleLabel.font = MFont(15);
    logonBtn.backgroundColor =[UIColor clearColor];
    [logonBtn setTitle:@"现在注册 >" forState:BtnNormal];
    [logonBtn setTitleColor:__DefaultColor forState:BtnNormal];
    [logonBtn addTarget:self action:@selector(Logon) forControlEvents:BtnTouchUpInside];

    YshareChooseView *shareV = [[YshareChooseView alloc]initWithFrame:CGRectMake(0, CGRectYH(logonBtn)+60, __kWidth, 110)];
    [_backV addSubview:shareV];
    shareV.delegate =self;
    
    
    
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ==获取验证码==
-(void)getCode{
    NSLog(@"获取验证码");
    [self.view endEditing:YES];
    [JKHttpRequestService POST:@"Register/short_message_send" withParameters:@{@"mobile":_mobile} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {

        }
    } failure:^(NSError *error) {

    } animated:YES];
}
#pragma mark ==登录==
-(void)Login{
    NSLog(@"登录");
    [self.view endEditing:YES];
    if (IsNilString(_mobile)||IsNilString(_verify)) {
        return;
    }
    [JKHttpRequestService POST:@"Register/short_login" withParameters:@{@"mobile":_mobile,@"verify":_verify} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary*dic = jsonDic[@"data"];
            NSString *name =dic[@"mobile"];
            [UdStorage storageObject:dic[@"app_user_type"] forKey:UserType];
            [UdStorage storageObject:dic[@"app_user_id"] forKey:Userid];
            EMError *error = nil;
            [[EaseMob sharedInstance].chatManager loginWithUsername:name password:name error:&error];
            if (!error.errorCode) {
                NSLog(@"登录成功");
                 [UdStorage storageObject:name forKey:UserName];
                 [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                NSLog(@"%@%ld",error.description,(long)error.errorCode);
            }
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

#pragma mark ==VIP登录==
-(void)vipLogin{
    NSLog(@"VIP登录");
}

#pragma mark ==无法登录==
-(void)cannotLogin{
    NSLog(@"账户登录");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ==注册==
-(void)Logon{
    NSLog(@"注册");
    YRegisterViewController *vc= [[YRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YshareChooseViewDelegate==
-(void)chooseShare:(NSInteger)sender{
    NSArray *list = @[@"qq",@"微信"];
    NSLog(@"%@",list[sender]);
    switch (sender) {
        case 0:
        {
            [ShareSDK getUserInfo:SSDKPlatformTypeQQ
                   onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
             {
                 if (state == SSDKResponseStateSuccess)
                 {

                     NSLog(@"uid=%@",user.uid);
                     NSLog(@"%@",user.credential);
                     NSLog(@"token=%@",user.credential.token);
                     NSLog(@"nickname=%@",user.nickname);
                 }

                 else
                 {
                     NSLog(@"%@",error);
                 }

             }];
        }
            break;
        case 1:
        {
            [ShareSDK getUserInfo:SSDKPlatformTypeWechat
                   onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
             {
                 if (state == SSDKResponseStateSuccess)
                 {

                     NSLog(@"uid=%@",user.uid);
                     NSLog(@"%@",user.credential);
                     NSLog(@"token=%@",user.credential.token);
                     NSLog(@"nickname=%@",user.nickname);
                 }

                 else
                 {
                     NSLog(@"%@",error);
                 }

             }];
        }
            break;

        default:
            break;
    }
}


#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag) {
        _verify = textField.text;
    }else{
        _mobile = textField.text;
    }
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleDefault;
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
