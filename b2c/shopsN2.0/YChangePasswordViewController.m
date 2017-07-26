//
//  YChangePasswordViewController.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YChangePasswordViewController.h"

@interface YChangePasswordViewController ()<UITextFieldDelegate>

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) NSString *oldPassword;

@property (strong,nonatomic) NSString *passWord;

@property (strong,nonatomic) NSString *againPassword;

@end

@implementation YChangePasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.rightBtn.hidden = YES;
    [self initView];
}

-(void)initView{
    _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];

    NSArray *imageArr = @[@"login_password",@"password_2",@"password_3"];
    for (int i=0; i<3; i++) {
        UIView *putV = [[UIView alloc]initWithFrame:CGRectMake(10, 20+66*i, __kWidth-20, 56)];
        [_backV addSubview:putV];
        putV.backgroundColor = LH_RGBCOLOR(245, 245, 245);
        putV.layer.cornerRadius = 5;

        UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(18, 15, 22, 26)];
        [putV addSubview:headIV];
        headIV.image = MImage(imageArr[i]);
        headIV.contentMode = UIViewContentModeScaleAspectFit;

        UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(60, 20, __kWidth-90, 20)];
        [putV addSubview:inputTF];
        inputTF.font = MFont(14);
        inputTF.tag = i;
        inputTF.delegate = self;
        inputTF.textAlignment = NSTextAlignmentLeft;
        inputTF.secureTextEntry = YES;
        switch (i) {
            case 0:
            {
                headIV.frame = CGRectMake(18, 15, 22, 26);
                inputTF.placeholder = @"请输入原密码...";
            }
                break;
            case 1:
            {
                headIV.frame = CGRectMake(17, 16, 23, 25);
                inputTF.placeholder = @"请输入新密码...";
            }
                break;
            case 2:
            {
                headIV.frame = CGRectMake(17, 15, 24, 27);
                inputTF.placeholder = @"请再次输入新密码...";
            }
                break;
            default:
                break;
        }
    }

    UIButton *changeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 236, __kWidth-20, 44)];
    [_backV addSubview:changeBtn];
    changeBtn.backgroundColor = __DefaultColor;
    changeBtn.titleLabel.font = MFont(15);
    changeBtn.layer.cornerRadius = 5;
    [changeBtn setTitle:@"确认修改" forState:BtnNormal];
    [changeBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [changeBtn addTarget:self action:@selector(change) forControlEvents:BtnTouchUpInside];
}
#pragma mark ==修改==
-(void)change{
    [self.view endEditing:YES];
    NSLog(@"确认修改");
    WK(weakSelf)
    [JKHttpRequestService POST:@"Pcenter/modifyPassword" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"password":_oldPassword,@"newPassword1":_passWord,@"newPassword2":_againPassword} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            __typeof(&*weakSelf) strongSelf = weakSelf;
            [SXLoadingView showAlertHUD:@"修改成功" duration:SXLoadingTime];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [SXLoadingView showAlertHUD:@"修改失败" duration:SXLoadingTime];
    } animated:YES];
}

#pragma mark ==UITextfiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag==0) {
        _oldPassword = textField.text;
    }else if (textField.tag ==1){
        _passWord = textField.text;
    }else{
        _againPassword = textField.text;
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
