//
//  YShopNullView.h
//  shopsN
//
//  Created by imac on 2017/1/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YShopNullViewDelegate <NSObject>

-(void)goBuying;

@end

@interface YShopNullView : BaseView

@property (weak,nonatomic) id<YShopNullViewDelegate>delegate;

@end
