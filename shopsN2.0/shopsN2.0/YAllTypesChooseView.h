//
//  YAllTypesChooseView.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YAllTypesChooseViewDelegate <NSObject>

-(void)chooseOrderType:(NSInteger)sender;

@end

@interface YAllTypesChooseView : BaseView

@property (strong,nonatomic) NSArray *typeArr;

@property (weak,nonatomic) id<YAllTypesChooseViewDelegate>delegate;

@end
