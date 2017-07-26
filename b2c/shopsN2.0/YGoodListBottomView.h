//
//  YGoodListBottomView.h
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodListBottomViewDelegate <NSObject>

-(void)GoodListAction:(NSInteger)sender;

@end

@interface YGoodListBottomView : BaseView

@property (weak,nonatomic) id<YGoodListBottomViewDelegate>delegate;

@end
