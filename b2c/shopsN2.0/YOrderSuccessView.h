//
//  YOrderSuccessView.h
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YOrderSuccessViewDelegate <NSObject>

-(void)makelookOrder;

@end

@interface YOrderSuccessView : BaseView

@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *address;

@property (strong,nonatomic) NSString *money;

@property (weak,nonatomic) id<YOrderSuccessViewDelegate>delegate;

@end
