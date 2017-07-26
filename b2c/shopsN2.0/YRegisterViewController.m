//
//  YRegisterViewController.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YRegisterViewController.h"

@interface YRegisterViewController ()<UITextFieldDelegate>

@property (strong,nonatomic) UIScrollView *backV;

@property (strong,nonatomic) NSString *name;//用户名

@property (strong,nonatomic) NSString *mobile;//手机

@property (strong,nonatomic) NSString *passWord;//密码

@property (strong,nonatomic) NSString *verify;//验证码

@property (strong,nonatomic) NSString *email;//邮箱

@property (strong,nonatomic) NSString *re_password;//验证密码

@property (strong,nonatomic) NSString *referralCode;//推荐码

@property (assign,nonatomic) NSInteger textFiledKey;


@end

@implementation YRegisterViewController

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
    [self getNavis];
    [self initView];
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
    titleLb.text = [NSString stringWithFormat:@"%@账户注册",ShortTitle];
}


-(void)initView{
    _backV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self.view addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];
    [self.view sendSubviewToBack:_backV];
    _backV.contentSize = CGSizeMake(__kWidth, 667+70);

    //main
    UIImageView *loginIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-173)/2, 74, 173, 39)];
    [_backV addSubview:loginIV];
    loginIV.image =MImage(@"loginLogo");
    loginIV.contentMode = UIViewContentModeScaleAspectFit;

    NSArray *imageArr =@[@"login_user",@"login_phone",@"login_SMS",@"login_SMS",@"login_password",@"login_password",@"login_rec"];
    for (int i=0; i<imageArr.count; i++) {
        UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectYH(loginIV)+20+70*i, __kWidth-60, 56)];
        [_backV addSubview:putV];
        putV.backgroundColor= LH_RGBCOLOR(245, 245, 245);

        UIImageView *headIV = [[UIImageView alloc]init];
        [putV addSubview:headIV];
        headIV.image =MImage(imageArr[i]);

        UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(60, 18, __kWidth-180, 20)];
        [putV addSubview:inputTF];
        inputTF.font = MFont(14);
        inputTF.tag = i;
        inputTF.secureTextEntry = NO;
        inputTF.delegate = self;
        inputTF.textAlignment = NSTextAlignmentLeft;
        switch (i) {
            case 0:{
                headIV.frame = CGRectMake(17, 15, 23, 28);
                inputTF.placeholder = @"请输入用户名...";
            }
                break;
            case 1:{
                headIV.frame = CGRectMake(19, 16, 19, 26);
                inputTF.placeholder = @"请输入验证手机号码...";
            }
                break;
            case 2:{
                headIV.frame = CGRectMake(18, 20, 21, 17);
                UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-145, 1.5, 85, 53)];
                [putV addSubview:codeBtn];
                codeBtn.titleLabel.font = MFont(15);
                codeBtn.backgroundColor = [UIColor whiteColor];
                [codeBtn setTitle:@"获取验证码" forState:BtnNormal];
                [codeBtn setTitleColor:__TextColor forState:BtnNormal];
                [codeBtn addTarget:self action:@selector(getCode) forControlEvents:BtnTouchUpInside];
                inputTF.placeholder = @"请输入短信验证码";
            }
                break;
            case 3:{
                headIV.frame = CGRectMake(18, 20, 21, 17);
                 inputTF.placeholder = @"请输入邮箱...";
            }
                break;
            case 4:{
                headIV.frame = CGRectMake(17, 15, 22, 26);
                inputTF.placeholder = @"请输入密码...";
                inputTF.secureTextEntry = YES;
            }
                break;
            case 5:{
                headIV.frame=CGRectMake(17, 15, 22, 26);
                inputTF.placeholder = @"请再次确认密码...";
                inputTF.secureTextEntry = YES;
            }
                break;
            case 6:{
                headIV.frame = CGRectMake(17, 16, 25, 24);
                inputTF.placeholder = @"选填推荐码...";
                
            }
                break;

            default:
                break;
        }
    }
    UIButton *registerBtn= [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectYH(loginIV)+450+70, __kWidth-60, 56)];
    [_backV addSubview:registerBtn];
    registerBtn.backgroundColor = __DefaultColor;
    registerBtn.layer.cornerRadius = 28;
    registerBtn.titleLabel.font = BFont(18);
    [registerBtn setTitle:@"注册" forState:BtnNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [registerBtn addTarget:self action:@selector(regiSter) forControlEvents:BtnTouchUpInside];

    UIButton *goLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth+80)/4, CGRectYH(registerBtn)+10, (__kWidth-80)/2, 20)];
    [_backV addSubview:goLoginBtn];
    goLoginBtn.backgroundColor = [UIColor clearColor];
    goLoginBtn.titleLabel.font = MFont(15);
    [goLoginBtn setTitle:@"已有账号 >" forState:BtnNormal];
    [goLoginBtn setTitleColor:__TextColor forState:BtnNormal];
    [goLoginBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];

}

#pragma mark ==注册==
-(void)regiSter{
    NSLog(@"注册");
    [self.view endEditing:YES];
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Register/register" withParameters:@{@"user_name":_name,@"mobile":_mobile,@"verify":_verify,@"email":_email,@"password":_passWord,@"re_password":_re_password} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            EMError *error = nil;
            [[EaseMob sharedInstance].chatManager registerNewAccount:weakSelf.mobile password:weakSelf.mobile error:&error];
            if (!error.errorCode) {
                NSLog(@"注册成功");
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"%@%ld",error.description,(long)error.errorCode);
            }
        }
    } failure:^(NSError *error) {

    } animated:YES];

}


#pragma mark ==获取验证码==
-(void)getCode{
    NSLog(@"获取验证码");
    [self.view endEditing:YES];
    if (IsNilString(_name)||IsNilString(_mobile)) {
        return;
    }
    [JKHttpRequestService POST:@"Register/re_send_msg" withParameters:@{@"user_name":_name,@"mobile":_mobile} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:jsonDic[@"msg"] duration:0.5];
        }
    } failure:^(NSError *error) {
        [SXLoadingView showAlertHUD:@"请求失败" duration:1.5];
    } animated:YES];
}
#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _textFiledKey= textField.tag;
    return YES;
}



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            _name = textField.text;
            break;
        case 1:
            _mobile = textField.text;
            if (![self checkPhone]) {
                [SXLoadingView showAlertHUD:@"手机号码格式不对，请重新输入" duration:0.5];
            }
            break;
        case 2:
            _verify = textField.text;
            break;
        case 3:
            _email = textField.text;
            break;
        case 4:
            _passWord = textField.text;
            break;
        case 5:
            _re_password = textField.text;
            break;
        case 6:
            _referralCode = textField.text;
            break;
        default:
            break;
    }
    return YES;
}

-(void)changeFrame:(CGFloat)height{
    _backV.transform = CGAffineTransformMakeTranslation(0, height);
}


- (BOOL)checkPhone {
    NSString *phoneTest = @"^1[0-9]{10}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneTest];
    if ([mobileTest evaluateWithObject:_mobile]) {
        return YES;
    }else{
        return NO;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleDefault;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
