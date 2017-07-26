//
//  BaseNavigationController.m
//  shopSN
//
//  Created by imac on 15/12/1.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "BaseNavigationController.h"



@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationBar setBarTintColor:HEXCOLOR(0xffffff)];
    
    
    [self.navigationBar setBackgroundImage:MImage(@"topBG_w") forBarMetrics:UIBarMetricsDefault];

    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:HEXCOLOR(0x333333),NSFontAttributeName:MFont(17)};
    self.navigationBar.shadowImage=[[UIImage alloc]init];



    //底部线条
//    UIImageView *lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, __kWidth, 1)];
//    lineIV.backgroundColor = HEXCOLOR(0xdedede);
//    [self.view addSubview:lineIV];

}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return  UIStatusBarStyleLightContent;
//}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    [super pushViewController:viewController animated:animated];
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
