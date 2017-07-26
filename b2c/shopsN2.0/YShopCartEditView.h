//
//  YShopCartEditView.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YShopCartEditViewDelegate <NSObject>

-(void)SureCancel:(BOOL)sender;

-(void)sureShare;

-(void)sureCollect;

@end

@interface YShopCartEditView : BaseView

@property (nonatomic) BOOL allChoose;

@property (weak,nonatomic) id<YShopCartEditViewDelegate>delegate;

@end
