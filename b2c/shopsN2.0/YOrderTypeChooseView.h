//
//  YOrderTypeChooseView.h
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YOrderTypeChooseViewDelegate <NSObject>

-(void)chooseOrderType:(NSInteger)sender;

@end

@interface YOrderTypeChooseView : BaseView

@property (nonatomic) NSInteger selectIndex;

@property (weak,nonatomic) id<YOrderTypeChooseViewDelegate>delegate;

@end
