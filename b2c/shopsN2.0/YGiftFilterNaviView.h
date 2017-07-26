//
//  YGiftFilterNaviView.h
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGiftFilterNaviViewDelegate <NSObject>

-(void)giftNaviAction:(NSInteger)sender;

@end

@interface YGiftFilterNaviView : BaseView

@property (strong,nonatomic) NSString *title;

@property (weak,nonatomic) id<YGiftFilterNaviViewDelegate>delegate;

@end
