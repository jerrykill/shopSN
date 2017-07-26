//
//  YFoundEmailViewController.m
//  shopsN
//
//  Created by imac on 2016/12/6.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFoundEmailViewController.h"


@interface YFoundEmailViewController ()<UITextFieldDelegate>

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UIImageView *codeIV;

@end

@implementation YFoundEmailViewController
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

#pragma mark ==导航栏==
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

    UIView *emailV = [[UIView alloc]initWithFrame:CGRectMake(30, 20, __kWidth-60, 56)];
    [_backV addSubview:emailV];
    emailV.backgroundColor = LH_RGBCOLOR(245, 245, 245);
    emailV.layer.cornerRadius = 5;

    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(18, 21, 22, 17)];
    [emailV addSubview:headIV];
    headIV.image = MImage(@"find_SMS");

    UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(60, 18, __kWidth-160, 20)];
    [emailV addSubview:inputTF];
    inputTF.font = MFont(14);
    inputTF.tag = 0;
    inputTF.placeholder = @"请输入注册验证邮箱";
    inputTF.textColor = LH_RGBCOLOR(153, 153, 153);
    inputTF.delegate = self;
    inputTF.textAlignment = NSTextAlignmentLeft;

    UILabel *warnLb = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectYH(emailV)+5, __kWidth-60, 15)];
    [_backV addSubview:warnLb];
    warnLb.textColor = LH_RGBCOLOR(153, 153, 153);
    warnLb.font = MFont(12);
    warnLb.textAlignment = NSTextAlignmentLeft;
    warnLb.backgroundColor = [UIColor clearColor];
    warnLb.text = @"* 请发送验证邮件至注册邮箱进行认证";

    UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectYH(warnLb)+20, __kWidth-190, 56)];
    [_backV addSubview:putV];
    putV.backgroundColor = LH_RGBCOLOR(245, 245, 245);
    putV.layer.cornerRadius = 5;

    UIImageView *picIV = [[UIImageView alloc]initWithFrame:CGRectMake(17, 17, 23, 24)];
    [putV addSubview:picIV];
    picIV.image = MImage(@"login_verification");

    UITextField *picTF =[[UITextField alloc]initWithFrame:CGRectMake(60, 18, __kWidth-250, 20)];
    [putV addSubview:picTF];
    picTF.font = MFont(14);
    picTF.tag = 1;
    picTF.placeholder = @"图片验证码";
    picTF.delegate = self;
    picTF.textAlignment = NSTextAlignmentLeft;

    _codeIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(putV)+5, CGRectYH(warnLb)+32, 81, 32)];
    [_backV addSubview:_codeIV];
    _codeIV.backgroundColor = LH_RandomColor;

    UIButton *changeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_codeIV), CGRectYH(warnLb)+32, 50, 32)];
    [_backV addSubview:changeBtn];
    changeBtn.titleLabel.font = MFont(14);
    [changeBtn setTitle:@"换一张" forState:BtnNormal];
    [changeBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [changeBtn addTarget:self action:@selector(change) forControlEvents:BtnTouchUpInside];

    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectYH(putV)+40, __kWidth-60, 56)];
    [_backV addSubview:sendBtn];
    sendBtn.layer.cornerRadius = 28;
    sendBtn.backgroundColor = __DefaultColor;
    sendBtn.titleLabel.font = BFont(18);
    [sendBtn setTitle:@"发送" forState:BtnNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [sendBtn addTarget:self action:@selector(send) forControlEvents:BtnTouchUpInside];

    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth-130)/2, CGRectYH(sendBtn)+20, 130, 15)];
    [_backV addSubview:phoneBtn];
    phoneBtn.backgroundColor = [UIColor clearColor];
    phoneBtn.titleLabel.font = MFont(14);
    [phoneBtn setTitle:@"使用注册手机找回" forState:BtnNormal];
    [phoneBtn setTitleColor:LH_RGBCOLOR(117, 117, 117) forState:BtnNormal];
    [phoneBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];
}


#pragma mark ==换一张==
-(void)change{
    NSLog(@"换一张图");
}

#pragma mark ==发送邮件==
-(void)send{
    NSLog(@"发送");
}


#pragma mark ==UITextFiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
        {
            NSLog(@"邮箱：%@",textField.text);
        }
            break;
        case 1:{
            NSLog(@"验证码：%@",textField.text);
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
