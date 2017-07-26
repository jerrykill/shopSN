//
//  YGoodsFilterView.h
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodsFilterViewDelegate <NSObject>

-(void)chooseType:(NSInteger)sender;

@end

@interface YGoodsFilterView : BaseView

@property (weak,nonatomic) id<YGoodsFilterViewDelegate>delegate;

@end
