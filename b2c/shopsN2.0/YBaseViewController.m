//
//  YBaseViewController.m
//  shopsN
//
//  Created by imac on 2016/11/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"

@interface YBaseViewController ()<YPopViewDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) NSArray *list;

@property (strong,nonatomic) NSArray *images;


@end

@implementation YBaseViewController

-(void)dealloc{
    [_popV removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
    [IQKeyboardManager sharedManager].enable = YES;
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
    [IQKeyboardManager sharedManager].enable = NO;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __BackColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getNavi];
    _list = @[@"首页",@"消息"];
    _images =@[@"home",@"news"];
}



-(void)getNavi{
    _headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:_headV];
    _headV.backgroundColor = LH_RGBCOLOR(208, 17, 27);
    [self.view bringSubviewToFront:_headV];

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-200)/2, 32, 200, 20)];
    [_headV addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = BFont(18);
    _titleLb.textColor = [UIColor whiteColor];

    _LeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 29, 25, 25)];
    [_headV addSubview:_LeftBtn];
    _LeftBtn.layer.cornerRadius = 12.5;
    [_LeftBtn setImage:MImage(@"back") forState:BtnNormal];
    [_LeftBtn addTarget:self action:@selector(back) forControlEvents:BtnTouchUpInside];

    _rightBtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 29, 25, 25)];
    [_headV addSubview:_rightBtn];
    [_rightBtn setImage:MImage(@"more") forState:BtnNormal];
    _rightBtn.titleLabel.font = MFont(15);
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_rightBtn addTarget:self action:@selector(chooseRight) forControlEvents:BtnTouchUpInside];
}

//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseRight{
    [self.view addSubview:self.popV];
    [self.view bringSubviewToFront:_popV];
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_popV];
}

#pragma mark ==懒加载==
-(YPopView *)popV{
    if (!_popV) {
        _popV = [[YPopView alloc]initWithFrame:CGRectMake(__kWidth-40, 8, __kWidth, __kHeight-60) title:_list image:_images];
        _popV.delegate = self;
        _popV.userInteractionEnabled = YES;
    }
    return _popV;
}

#pragma mark ==YPopViewDelegate==
-(void)chooseIndex:(NSInteger)index{
    if (index==0) {
        dispatch_async(dispatch_get_main_queue(), ^{
        YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
        tab.selectIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else{
        YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_popV removeFromSuperview];
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
