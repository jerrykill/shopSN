//
//  YOrderEvaluteFootView.h
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YOrderEvaluteFootViewDelegate <NSObject>

-(void)chooseStar:(NSInteger)star;

@end

@interface YOrderEvaluteFootView : BaseView

@property (weak,nonatomic) id<YOrderEvaluteFootViewDelegate>delegate;


@end
