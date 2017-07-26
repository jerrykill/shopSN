//
//  YBaseViewController.h
//  shopsN
//
//  Created by imac on 2016/11/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBaseViewController : UIViewController

@property (copy,nonatomic) NSString *title;



@property (strong,nonatomic) UIButton *LeftBtn;

@property (strong,nonatomic) UIButton *rightBtn;

@property (strong,nonatomic) UIView *headV;

@property (strong,nonatomic) YPopView *popV;

@end
