//
//  YPersonAppraiseTypeView.h
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YPersonAppraiseTypeViewDelegate <NSObject>

-(void)chooseView:(NSInteger)tag;

@end

@interface YPersonAppraiseTypeView : BaseView

@property (strong,nonatomic) NSArray *countArr;

@property (weak,nonatomic) id<YPersonAppraiseTypeViewDelegate>delegate;

@end
