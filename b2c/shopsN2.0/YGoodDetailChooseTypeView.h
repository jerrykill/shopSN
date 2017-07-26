//
//  YGoodDetailChooseTypeView.h
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"

@protocol YGoodDetailChooseTypeViewDelegate <NSObject>

-(void)chooseDetailView:(NSInteger)sender;

@end

@interface YGoodDetailChooseTypeView : BaseView

@property (assign,nonatomic) NSInteger selectIndex;

@property (weak,nonatomic) id<YGoodDetailChooseTypeViewDelegate>delegate;

@end
