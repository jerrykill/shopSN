//
//  YReturnsHeadView.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YReturnsHeadViewDelegate <NSObject>

-(void)chooseType:(NSInteger)sender;

-(void)searchDid:(NSString *)text;

@end

@interface YReturnsHeadView : BaseView


@property (weak,nonatomic) id<YReturnsHeadViewDelegate>delegate;

@end
