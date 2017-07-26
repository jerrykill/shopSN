//
//  YGoodAppraiseTypeView.h
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodAppraiseTypeViewDelegate <NSObject>

-(void)chooseAppraiseType:(NSInteger)sender;

@end

@interface YGoodAppraiseTypeView : BaseView

@property (strong,nonatomic) NSArray *numArr;

@property (weak,nonatomic) id<YGoodAppraiseTypeViewDelegate>delegate;

@end
