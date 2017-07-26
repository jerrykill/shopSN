//
//  YSLoginViewController.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSLoginViewController.h"
#import "YshareChooseView.h"
#import "YnoteLoginViewController.h"
#import "YRegisterViewController.h"
#import "YFoundPasswordViewController.h"
#import "YSThreePinlessViewController.h"


@interface YSLoginViewController ()<UITextFieldDelegate,YshareChooseViewDelegate>

@property (strong,nonatomic) UIScrollView *backV;

@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *passWord;

@end

@implementation YSLoginViewController

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
    titleLb.text = [NSString stringWithFormat:@"%@账户登录",ShortTitle];
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

    NSArray *imageArr = @[@"login_user",@"login_password"];
    for (int i=0; i<2; i++) {
        UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(30, 30+CGRectYH(loginIV)+70*i, __kWidth-60, 56)];
        [_backV addSubview:putV];
        putV.backgroundColor = LH_RGBCOLOR(245, 245, 245);
        putV.layer.cornerRadius = 5;

        UIImageView *headIV = [[UIImageView alloc]init];
        [putV addSubview:headIV];
        headIV.image = MImage(imageArr[i]);

        UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(60, 18, __kWidth-140, 20)];
        [putV addSubview:inputTF];
        inputTF.font = MFont(14);
        inputTF.tag = i;
        inputTF.delegate = self;
        inputTF.textAlignment = NSTextAlignmentLeft;
        if (!i) {
            headIV.frame = CGRectMake(17, 15, 23, 28);
            inputTF.placeholder = @"邮箱/用户名/已验证手机";
        }else{
            headIV.frame = CGRectMake(17, 15, 22, 26);
            inputTF.placeholder = @"请输入密码...";
            inputTF.secureTextEntry = YES;
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

    UIButton *cannotBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectYH(loginBtn)+10, (__kWidth-80)/2, 20)];
    [_backV addSubview:cannotBtn];
    cannotBtn.titleLabel.font = MFont(15);
    cannotBtn.backgroundColor = [UIColor clearColor];
    [cannotBtn setTitle:@"无法登陆?" forState:BtnNormal];
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

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ==登录==
-(void)Login{
    NSLog(@"登录");
    [self.view endEditing:YES];
    if (IsNilString(_name)||IsNilString(_passWord)) {
        return;
    }
    [JKHttpRequestService POST:@"Register/login_account" withParameters:@{@"account":_name,@"password":_passWord} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = jsonDic[@"data"];
            NSString *name =dic[@"mobile"];
            [UdStorage storageObject:dic[@"app_user_type"] forKey:UserType];
            [UdStorage storageObject:dic[@"app_user_id"] forKey:Userid];
            EMError *error = nil;
            [[EaseMob sharedInstance].chatManager loginWithUsername:name password:name error:&error];
            if (!error.errorCode) {
                NSLog(@"登录成功");
                [UdStorage storageObject:_name forKey:UserName];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                NSLog(@"%@%ld",error.description,(long)error.errorCode);
            }
        }
    } failure:^(NSError *error) {

    } animated:YES];



}



#pragma mark ==无法登录==
-(void)cannotLogin{
    NSLog(@"无法登录？");

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"短信验证登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"短信登录");
        YnoteLoginViewController *vc = [[YnoteLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"找回密码");
        YFoundPasswordViewController *vc = [[YFoundPasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ==注册==
-(void)Logon{
    NSLog(@"注册");
    YRegisterViewController *vc = [[YRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YshareChooseViewDelegate==
-(void)chooseShare:(NSInteger)sender{
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
                     [self threeLogin:@{@"type":@"1",@"accout":user.uid}];
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
                     [self threeLogin:@{@"type":@"2",@"accout":user.uid}];
                 }

                 else
                 {
                     NSLog(@"%@",error);
                 }
                 
             }];
        }
            break;
//        case 2:
//        {
//            [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
//                   onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//             {
//                 if (state == SSDKResponseStateSuccess)
//                 {
//
//                     NSLog(@"uid=%@",user.uid);
//                     NSLog(@"%@",user.credential);
//                     NSLog(@"token=%@",user.credential.token);
//                     NSLog(@"nickname=%@",user.nickname);
//                     #pragma mark ==该处新浪微博登录需要后台根据API重写接口==
//                     [self threeLogin:@{@"type":@"3",@"accout":@""}];
//                 }
//
//                 else
//                 {
//                     NSLog(@"%@",error);
//                 }
//                 
//             }];
//        }
//            break;
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
        _passWord = textField.text;
    }else{
         _name = textField.text;
    }
    return YES;
}

#pragma mark ==跳转第三方==
- (void)threeLogin:(NSDictionary*)paramas{
  [JKHttpRequestService POST:@"Register/otherLogin" withParameters:paramas success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
      if (succe) {
          NSDictionary *dic =jsonDic[@"data"];
          EMError *error = nil;
          [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:dic[@"mobile"] password:dic[@"mobile"] completion:^(NSDictionary *loginInfo, EMError *error) {
              if (!error.errorCode) {
                  NSLog(@"登录成功");
                  [UdStorage storageObject:dic[@"mobile"] forKey:UserName];
                  [UdStorage storageObject:dic[@"app_user_id"] forKey:Userid];
                  [UdStorage storageObject:dic[@"app_user_type"] forKey:UserType];
                  [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                  [self dismissViewControllerAnimated:YES completion:nil];
              }else{
                  NSLog(@"%@%ld",error.description,(long)error.errorCode);
              }

          } onQueue:nil];
      }else{
          YSThreePinlessViewController *vc = [[YSThreePinlessViewController alloc]init];
          vc.type =paramas[@"type"];
          vc.accout = paramas[@"accout"];
          [self.navigationController pushViewController:vc animated:YES];
      }
  } failure:^(NSError *error) {

  } animated:NO];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
