//
//  YShopCartClearView.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YShopCartTotalModel.h"

@protocol YShopCartClearViewDelegate <NSObject>

-(void)clear;

//- (void)chooseAttend:(BOOL)sender;

@end

@interface YShopCartClearView : BaseView

@property (strong,nonatomic) YShopCartTotalModel *model;

@property (weak,nonatomic) id<YShopCartClearViewDelegate>delegate;

@end
