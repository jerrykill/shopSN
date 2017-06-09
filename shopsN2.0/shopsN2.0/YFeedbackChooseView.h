//
//  YFeedbackChooseView.h
//  shopsN
//
//  Created by imac on 2017/2/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YFeedbackChooseViewDelegate <NSObject>

-(void)chooseFeedType:(NSString *)type;

@end

@interface YFeedbackChooseView : BaseView

@property (strong,nonatomic) NSArray *typeArr;

@property (weak,nonatomic) id<YFeedbackChooseViewDelegate>delegate;

@end
