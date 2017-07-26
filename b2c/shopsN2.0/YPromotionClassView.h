//
//  YPromotionClassView.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YPromotionClassModel.h"

@protocol YPromotionClassViewDelegate <NSObject>

-(void)chooseTagV:(NSString *)sender;

@end

@interface YPromotionClassView : BaseView

@property (strong,nonatomic) YPromotionClassModel *model;

@property (weak,nonatomic) id<YPromotionClassViewDelegate>delegate;

@end
