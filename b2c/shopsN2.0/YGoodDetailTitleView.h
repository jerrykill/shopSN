//
//  YGoodDetailTitleView.h
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGoodDetailModel.h"

@protocol YGoodDetailTitleViewDelegate <NSObject>

-(void)goodShare;

@end

@interface YGoodDetailTitleView : BaseView

@property (strong,nonatomic) YGoodDetailModel *model;

@property (weak,nonatomic) id<YGoodDetailTitleViewDelegate>delegate;

@end
