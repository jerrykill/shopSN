//
//  YSThreePinlessViewController.m
//  shopsN
//
//  Created by imac on 2017/3/23.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSThreePinlessViewController.h"
#import "YRegisterViewController.h"
#import "YFoundPasswordViewController.h"

@interface YSThreePinlessViewController ()<UITextFieldDelegate>

@property (strong,nonatomic) UIScrollView *backV;

@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *passWord;

@end

@implementation YSThreePinlessViewController

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
    titleLb.text = [NSString stringWithFormat:@"%@登录绑定",ShortTitle];
}

- (void)initView{
    _backV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self.view addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];
    [self.view sendSubviewToBack:_backV];

    NSArray *imageArr = @[@"login_user",@"login_password"];
    for (int i=0; i<2; i++) {
        UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(30, 120+70*i, __kWidth-60, 56)];
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

    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 267, __kWidth-60, 56)];
    [_backV addSubview:loginBtn];
    loginBtn.backgroundColor = __DefaultColor;
    loginBtn.layer.cornerRadius = 28;
    loginBtn.titleLabel.font = MFont(18);
    [loginBtn setTitle:@"登录" forState:BtnNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [loginBtn addTarget:self action:@selector(Login) forControlEvents:BtnTouchUpInside];

    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectYH(loginBtn)+5, __kWidth-60, 56)];
    [_backV addSubview:registerBtn];
    registerBtn.backgroundColor = [UIColor whiteColor];
    registerBtn.layer.cornerRadius = 28;
    registerBtn.titleLabel.font = MFont(16);
    registerBtn.layer.borderColor =__BackColor.CGColor;
    registerBtn.layer.borderWidth = 1;
    NSMutableAttributedString *strs = [[NSMutableAttributedString alloc]initWithString:@"还没有账号？快速注册"];
    [strs addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(6, 4)];
    [registerBtn setAttributedTitle:strs forState:BtnNormal];
    [registerBtn addTarget:self action:@selector(logon) forControlEvents:BtnTouchUpInside];

    UIButton *forgotBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-110, CGRectYH(registerBtn)+50, 90, 30)];
    [_backV addSubview:forgotBtn];
    forgotBtn.titleLabel.font = MFont(15);
    NSMutableAttributedString *titles = [[NSMutableAttributedString alloc]initWithString:@"忘记密码？"];
    [titles addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, titles.length)];
    [forgotBtn setAttributedTitle:titles forState:BtnNormal];
    [forgotBtn setTitleColor:__DTextColor forState:BtnNormal];
    [forgotBtn addTarget:self action:@selector(forgetPassword) forControlEvents:BtnTouchUpInside];

}
#pragma mark ==登录==
- (void)Login{
    [JKHttpRequestService POST:@"Register/bindOtherAccount" withParameters:@{@"type":_type,@"accout":_accout,@"mobile":_name,@"password":_passWord} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic=jsonDic[@"data"];
            NSString *name =dic[@"mobile"];
            EMError *error = nil;
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:name password:name completion:^(NSDictionary *loginInfo, EMError *error) {
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
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)checkNUll{
    if (IsNilString(_passWord)||IsNilString(_name)) {
        [SXLoadingView showAlertHUD:@"数据不全，请填写完整" duration:SXLoadingTime];
        return;
    }
}

#pragma mark ==注册==
- (void)logon{
    YRegisterViewController *vc = [[YRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ==忘记密码==
- (void)forgetPassword{
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
