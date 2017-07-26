//
//  YSureOrderBottomView.h
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YSureOrderBottomViewDelegate <NSObject>

-(void)putOrder;

@end

@interface YSureOrderBottomView : BaseView

@property (strong,nonatomic) NSString *total;

@property (weak,nonatomic) id<YSureOrderBottomViewDelegate>delegate;

@end
