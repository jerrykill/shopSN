//
//  YGoodDetailsAppraiseView.h
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodDetailsAppraiseViewDelegate <NSObject>

-(void)getGoodBack;

@end

@interface YGoodDetailsAppraiseView : BaseView

@property (strong,nonatomic) NSString *goodID;

@property (weak,nonatomic) id<YGoodDetailsAppraiseViewDelegate>delegate;

@end
