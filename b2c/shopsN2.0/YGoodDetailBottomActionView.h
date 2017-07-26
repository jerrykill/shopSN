//
//  YGoodDetailBottomActionView.h
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodDetailBottomActionViewDelegate <NSObject>

-(void)chooseGoodAction:(NSInteger)index isCollect:(BOOL)sender;

@end

@interface YGoodDetailBottomActionView : BaseView

@property (nonatomic) BOOL isCollect;

@property (weak,nonatomic) id<YGoodDetailBottomActionViewDelegate>delegate;

@end
