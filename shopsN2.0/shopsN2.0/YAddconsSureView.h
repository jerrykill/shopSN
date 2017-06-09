//
//  YAddconsSureView.h
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YAddConsModel.h"

@protocol YAddconsSureViewDelegate <NSObject>

-(void)putCons:(YConsModel*)model;

@end


@interface YAddconsSureView : BaseView

@property (weak,nonatomic) id<YAddconsSureViewDelegate>delegate;

@end
