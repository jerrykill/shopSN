//
//  YScanViewController.h
//  shopsN
//
//  Created by imac on 2017/2/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"

@interface YScanViewController : YBaseViewController

@property (nonatomic,copy)void (^QRUrlBlock)(NSString *url);

@end
